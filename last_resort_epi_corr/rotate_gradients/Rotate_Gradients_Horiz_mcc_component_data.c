/*
 * MATLAB Compiler: 4.6 (R2007a)
 * Date: Mon Feb  7 13:23:19 2011
 * Arguments: "-B" "macro_default" "-m" "-W" "main" "-T" "link:exe"
 * "Rotate_Gradients_Horiz" 
 */

#include "mclmcr.h"

#ifdef __cplusplus
extern "C" {
#endif
const unsigned char __MCC_Rotate_Gradients_Horiz_session_key[] = {
        '0', 'B', '6', '9', '3', '4', '6', '0', '7', 'F', 'F', '9', 'A', '0',
        'E', '3', '3', '9', '6', '4', '0', '6', '3', 'A', 'A', 'E', '3', 'E',
        '3', 'E', '0', 'D', '3', '1', 'D', '2', 'D', 'D', 'C', 'C', 'E', 'A',
        'B', '0', '5', '6', 'C', 'C', 'D', '9', '4', '7', 'A', '4', '7', '4',
        'E', '7', 'B', '4', 'A', '4', '1', 'E', '1', '3', '1', '0', '7', '4',
        'D', '9', '1', 'C', '8', '2', 'A', '8', '8', '9', '4', 'D', '8', '9',
        '0', 'B', '6', 'B', '8', 'E', '8', '0', 'C', '9', '7', 'F', 'C', 'C',
        'E', '2', '9', 'B', 'B', 'C', '1', 'D', '1', 'D', 'B', '0', 'E', '8',
        '0', '3', '4', 'A', '5', '0', '6', '5', '9', '9', 'E', 'A', '2', '4',
        '7', 'A', 'A', '5', '3', '5', '8', '0', '2', '6', '2', 'D', '2', 'E',
        '0', 'F', '7', '9', 'A', '7', 'B', '7', 'E', '6', '2', '0', 'C', '2',
        '3', '6', '1', '3', 'F', 'B', '6', 'E', '9', 'E', '8', '4', '4', 'C',
        '3', '2', 'C', 'D', 'C', '7', '9', 'A', '7', '5', 'A', '1', '4', 'D',
        '2', '7', '8', '5', '8', '2', 'C', 'C', '4', '6', 'C', '4', '6', '0',
        'B', 'E', '2', '6', '6', '2', 'A', '0', 'C', 'D', '4', '9', '9', 'E',
        '7', '8', 'A', 'A', '4', '7', 'D', '3', '5', '1', 'D', '1', '4', 'C',
        'F', 'A', '1', '1', '3', '8', 'B', '5', 'F', '3', '5', '9', '8', 'B',
        '7', '1', 'F', 'C', '9', '8', 'C', '2', '7', 'B', 'D', '8', '1', 'E',
        'A', 'C', '6', '5', '\0'};

const unsigned char __MCC_Rotate_Gradients_Horiz_public_key[] = {
        '3', '0', '8', '1', '9', 'D', '3', '0', '0', 'D', '0', '6', '0', '9',
        '2', 'A', '8', '6', '4', '8', '8', '6', 'F', '7', '0', 'D', '0', '1',
        '0', '1', '0', '1', '0', '5', '0', '0', '0', '3', '8', '1', '8', 'B',
        '0', '0', '3', '0', '8', '1', '8', '7', '0', '2', '8', '1', '8', '1',
        '0', '0', 'C', '4', '9', 'C', 'A', 'C', '3', '4', 'E', 'D', '1', '3',
        'A', '5', '2', '0', '6', '5', '8', 'F', '6', 'F', '8', 'E', '0', '1',
        '3', '8', 'C', '4', '3', '1', '5', 'B', '4', '3', '1', '5', '2', '7',
        '7', 'E', 'D', '3', 'F', '7', 'D', 'A', 'E', '5', '3', '0', '9', '9',
        'D', 'B', '0', '8', 'E', 'E', '5', '8', '9', 'F', '8', '0', '4', 'D',
        '4', 'B', '9', '8', '1', '3', '2', '6', 'A', '5', '2', 'C', 'C', 'E',
        '4', '3', '8', '2', 'E', '9', 'F', '2', 'B', '4', 'D', '0', '8', '5',
        'E', 'B', '9', '5', '0', 'C', '7', 'A', 'B', '1', '2', 'E', 'D', 'E',
        '2', 'D', '4', '1', '2', '9', '7', '8', '2', '0', 'E', '6', '3', '7',
        '7', 'A', '5', 'F', 'E', 'B', '5', '6', '8', '9', 'D', '4', 'E', '6',
        '0', '3', '2', 'F', '6', '0', 'C', '4', '3', '0', '7', '4', 'A', '0',
        '4', 'C', '2', '6', 'A', 'B', '7', '2', 'F', '5', '4', 'B', '5', '1',
        'B', 'B', '4', '6', '0', '5', '7', '8', '7', '8', '5', 'B', '1', '9',
        '9', '0', '1', '4', '3', '1', '4', 'A', '6', '5', 'F', '0', '9', '0',
        'B', '6', '1', 'F', 'C', '2', '0', '1', '6', '9', '4', '5', '3', 'B',
        '5', '8', 'F', 'C', '8', 'B', 'A', '4', '3', 'E', '6', '7', '7', '6',
        'E', 'B', '7', 'E', 'C', 'D', '3', '1', '7', '8', 'B', '5', '6', 'A',
        'B', '0', 'F', 'A', '0', '6', 'D', 'D', '6', '4', '9', '6', '7', 'C',
        'B', '1', '4', '9', 'E', '5', '0', '2', '0', '1', '1', '1', '\0'};

static const char * MCC_Rotate_Gradients_Horiz_matlabpath_data[] = 
    { "Rotate_Gradients_Horiz/", "toolbox/compiler/deploy/",
      "$TOOLBOXMATLABDIR/general/", "$TOOLBOXMATLABDIR/ops/",
      "$TOOLBOXMATLABDIR/lang/", "$TOOLBOXMATLABDIR/elmat/",
      "$TOOLBOXMATLABDIR/elfun/", "$TOOLBOXMATLABDIR/specfun/",
      "$TOOLBOXMATLABDIR/matfun/", "$TOOLBOXMATLABDIR/datafun/",
      "$TOOLBOXMATLABDIR/polyfun/", "$TOOLBOXMATLABDIR/funfun/",
      "$TOOLBOXMATLABDIR/sparfun/", "$TOOLBOXMATLABDIR/scribe/",
      "$TOOLBOXMATLABDIR/graph2d/", "$TOOLBOXMATLABDIR/graph3d/",
      "$TOOLBOXMATLABDIR/specgraph/", "$TOOLBOXMATLABDIR/graphics/",
      "$TOOLBOXMATLABDIR/uitools/", "$TOOLBOXMATLABDIR/strfun/",
      "$TOOLBOXMATLABDIR/imagesci/", "$TOOLBOXMATLABDIR/iofun/",
      "$TOOLBOXMATLABDIR/audiovideo/", "$TOOLBOXMATLABDIR/timefun/",
      "$TOOLBOXMATLABDIR/datatypes/", "$TOOLBOXMATLABDIR/verctrl/",
      "$TOOLBOXMATLABDIR/codetools/", "$TOOLBOXMATLABDIR/helptools/",
      "$TOOLBOXMATLABDIR/demos/", "$TOOLBOXMATLABDIR/timeseries/",
      "$TOOLBOXMATLABDIR/hds/", "$TOOLBOXMATLABDIR/guide/",
      "$TOOLBOXMATLABDIR/plottools/", "toolbox/local/", "toolbox/compiler/" };

static const char * MCC_Rotate_Gradients_Horiz_classpath_data[] = 
    { "" };

static const char * MCC_Rotate_Gradients_Horiz_libpath_data[] = 
    { "" };

static const char * MCC_Rotate_Gradients_Horiz_app_opts_data[] = 
    { "" };

static const char * MCC_Rotate_Gradients_Horiz_run_opts_data[] = 
    { "" };

static const char * MCC_Rotate_Gradients_Horiz_warning_state_data[] = 
    { "off:MATLAB:dispatcher:nameConflict" };


mclComponentData __MCC_Rotate_Gradients_Horiz_component_data = { 

    /* Public key data */
    __MCC_Rotate_Gradients_Horiz_public_key,

    /* Component name */
    "Rotate_Gradients_Horiz",

    /* Component Root */
    "",

    /* Application key data */
    __MCC_Rotate_Gradients_Horiz_session_key,

    /* Component's MATLAB Path */
    MCC_Rotate_Gradients_Horiz_matlabpath_data,

    /* Number of directories in the MATLAB Path */
    35,

    /* Component's Java class path */
    MCC_Rotate_Gradients_Horiz_classpath_data,
    /* Number of directories in the Java class path */
    0,

    /* Component's load library path (for extra shared libraries) */
    MCC_Rotate_Gradients_Horiz_libpath_data,
    /* Number of directories in the load library path */
    0,

    /* MCR instance-specific runtime options */
    MCC_Rotate_Gradients_Horiz_app_opts_data,
    /* Number of MCR instance-specific runtime options */
    0,

    /* MCR global runtime options */
    MCC_Rotate_Gradients_Horiz_run_opts_data,
    /* Number of MCR global runtime options */
    0,
    
    /* Component preferences directory */
    "Rotate_Gradients_Horiz_57B2F263619218BDE30A3A644CB01794",

    /* MCR warning status data */
    MCC_Rotate_Gradients_Horiz_warning_state_data,
    /* Number of MCR warning status modifiers */
    1,

    /* Path to component - evaluated at runtime */
    NULL

};

#ifdef __cplusplus
}
#endif


