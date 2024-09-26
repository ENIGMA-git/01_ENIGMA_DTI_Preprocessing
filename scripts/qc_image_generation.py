#!/usr/bin/env python

# author: Alyssa H. Zhu

import nibabel as nib
import numpy as np
import argparse
import sys
import os
import matplotlib.pyplot as plt
# Maybe try PyPNG instead?

def reorient_img_data(image):
    img = nib.load(image)
    img_data = img.get_data()
    voxel_sizes = img.header.get_zooms()
    axcodes = nib.aff2axcodes(img.affine)

    if axcodes != ( 'R', 'A', 'S'):
        reorg_dim = np.zeros(3)
        for i, dim in enumerate(axcodes):
            if dim in ['L', 'P', 'I']:
                if i == 0:
                    img_data = img_data[::-1, :, :]
                elif i == 1:
                    img_data = img_data[:, ::-1, :]
                elif i == 2:
                    img_data = img_data[:, :, ::-1]
            if dim in ['L', 'R']:
                reorg_dim[0] == i
            elif dim in ['A', 'P']:
                reorg_dim[1] == i
            elif dim in ['S', 'I']:
                reorg_dim[2] == i
            else:
                print("Encountered unfamiliar orientation: %s" %dim)
                sys.exit(1)

        if np.array_equal(reorg_dim, np.arange(3)):
            img_data = np.moveaxis(img_data, reorg_dim, [0, 1, 2])
            voxel_sizes = voxel_sizes[reorg_dim]

    return img_data, voxel_sizes

def initiate_figure(nrows, ncols, figsize):
    fig, ax = plt.subplots(nrows, ncols, figsize=figsize)
    try:
        axes = ax.flatten()
        for a in axes:
            a.axis("off")
        return [fig, axes]
    except AttributeError:
        return [fig, ax]

def set_aspect_ratio(dim1, dim2):
    voxel_sizes = np.array([dim1, dim2])
    larger_ix = np.where(voxel_sizes == np.amax(voxel_sizes))[0][0]
    if larger_ix == 0:
        voxel_sizes /= voxel_sizes[1]
        return voxel_sizes[0]
    else:
        voxel_sizes /= voxel_sizes[0]
        return voxel_sizes[1]

def generate_x_mask_overlay(fig_object, img_data, mask_data, x, ix, vs):
    fig = fig_object[0]
    axes = fig_object[1]
    img_shape = img_data.shape
    mask_data = mask_data.astype(float)
    brain_ix = np.where(mask_data > 0)
    mask_data[mask_data == 0] = np.nan
    aspect_ratio = set_aspect_ratio(vs[1], vs[2])

    slice_x = img_data[x, :, :]
    mask_x = mask_data[x, :, :]
    axes[ix].imshow(slice_x.T, cmap="gray", origin="lower", aspect=aspect_ratio)
    axes[ix].imshow(mask_x.T, cmap='cool', origin="lower", alpha=0.4, aspect=aspect_ratio)
    axes[ix].axis('off')
    axes[ix].set_title("x = %i" %x)

    return [fig, axes]

def generate_y_mask_overlay(fig_object, img_data, mask_data, y, ix, vs):
    fig = fig_object[0]
    axes = fig_object[1]
    img_shape = img_data.shape
    mask_data = mask_data.astype(float)
    brain_ix = np.where(mask_data > 0)
    mask_data[mask_data == 0] = np.nan
    aspect_ratio = set_aspect_ratio(vs[0], vs[2])

    slice_y = img_data[:, y, :]
    mask_y = mask_data[:, y, :]
    axes[ix].imshow(slice_y.T, cmap="gray", origin="lower", aspect=aspect_ratio)
    axes[ix].imshow(mask_y.T, cmap='cool', origin="lower", alpha=0.4, aspect=aspect_ratio)
    axes[ix].axis('off')
    axes[ix].set_title("y = %i" %y)

    return [fig, axes]

def generate_z_mask_overlay(fig_object, img_data, mask_data, z, ix, vs):
    fig = fig_object[0]
    axes = fig_object[1]
    img_shape = img_data.shape
    mask_data = mask_data.astype(float)
    brain_ix = np.where(mask_data > 0)
    mask_data[mask_data == 0] = np.nan
    aspect_ratio = set_aspect_ratio(vs[0], vs[1])

    slice_z = img_data[:, :, z]
    mask_z = mask_data[:, :, z]
    axes[ix].imshow(slice_z.T, cmap="gray", origin="lower", aspect=aspect_ratio)
    axes[ix].imshow(mask_z.T, cmap='cool', origin="lower", alpha=0.4, aspect=aspect_ratio)
    axes[ix].axis('off')
    axes[ix].set_title("z = %i" %z)

    return [fig, axes]

if __name__ == "__main__":

    readme="""
    This script generates QC images of the requested slice numbers for input background and mask images.

    Ranges are an acceptable input to -x, -y, and -z

    N.B. Slice indexing is 0-based (e.g., 0-255)

    """

    parser = argparse.ArgumentParser(description=readme)
    parser.add_argument("-o", "--output", help="Output image name")
    parser.add_argument("-i", "--image", help="Background Image")
    parser.add_argument("-m", "--mask", help="Mask Image")
    parser.add_argument("-x", nargs="+", default=[], 
                        help="(optional) First dimension slice numbers (Sagittal)")
    parser.add_argument("-y", nargs="+", default=[], 
                        help="(optional) Second dimension slice numbers (Coronal)")
    parser.add_argument("-z", nargs="+", default=[], 
                        help="(optional) Third dimension slice numbers (Axial)")
    parser.add_argument("-s", nargs=2, default=[8.5,11],
                        help="(optional) Indicate image size in inches (e.g., -s 8.5 11); Default=8.5x11 inches")

    args = parser.parse_args()

    if len(args.x) + len(args.y) + len(args.z) == 0:
        print("One of -x, -y, or -z should be given.")
        sys.exit(1)

    x_slices = []
    y_slices = []
    z_slices = []

    for x in args.x:
        if "-" in x:
            x_slices += list(np.arange(int(x.split("-")[0]), int(x.split("-")[1])+1))
        else:
            x_slices.append(int(x))

    for y in args.y:
        if "-" in y:
            y_slices += list(np.arange(int(y.split("-")[0]), int(y.split("-")[1])+1))
        else:
            y_slices.append(int(y))

    for z in args.z:
        if "-" in z:
            z_slices += list(np.arange(int(z.split("-")[0]), int(z.split("-")[1])+1))
        else:
            z_slices.append(int(z))

    num_inputs = len(x_slices) + len(y_slices) + len(z_slices)
    num_rows = int(num_inputs/3)+1

    fig1 = initiate_figure(num_rows,3,(int(args.s[0]),int(args.s[1])))
    counter = 0

    if os.path.exists(args.image) and os.path.exists(args.mask):
        reoriented_mask, img_voxel_sizes = reorient_img_data(args.mask)
        reoriented_image, _ = reorient_img_data(args.image)
        for x in x_slices:
            fig1 = generate_x_mask_overlay(fig1, reoriented_image, reoriented_mask, x, counter, img_voxel_sizes)
            counter += 1
        for y in y_slices:
            fig1 = generate_y_mask_overlay(fig1, reoriented_image, reoriented_mask, y, counter, img_voxel_sizes)
            counter += 1
        for z in z_slices:
            fig1 = generate_z_mask_overlay(fig1, reoriented_image, reoriented_mask, z, counter, img_voxel_sizes)
            counter += 1
        fig1[0].savefig(args.output)
    else:
        print("One file is missing. Aborting...")
        sys.exit(1)
