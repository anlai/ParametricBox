# Parametric Box
 
A Gridfinity compatible parametric box that can be filled with Gridfinity bins and sizes of your choosing, you can configure the # of units (and height) from using the parametric configuration.  The sample sizes are 5x4x6u and 2x2x6u.  The bins are stackable and can be configured with Gridfinity bases on the outside to hook into your existing Gridfinity bases.

The generator is also capable of generating boxes that do not have the Gridfinity slots as well (and can be defined by a size of your choosing).

## Setup

Requirements:
- OpenSCAD nightly ("stable" version will not work)
- [Gridfinity Extended](https://github.com/ostat/gridfinity_extended_openscad) - clone repository into `./gridfinity-extended` folder, it will be referenced from the scad files in this repository

## Parameters

**General**

| Parameter Name | Value Type | Default Value | Description |
| --- | --- | --- | --- |
| type | string | gridfinity | |
| component | string | box | <br/>options: box, lid, label |
| stackable | boolean | false | |
| wall_thickness | float | 4 | |
| top_wall_thickness | float | 2 | |
| bottom_wall_thickness | float | 2.4 | |
| fudge | float | .3 | <br/>between 0-1 with .1 increments |

**Gridfinity**

| Parameter Name | Value Type | Default Value | Description |
| --- | --- | --- | --- |
| gf_width | int | 5 | |
| gf_depth | int | 5 | |
| gf_height | int | 6 | |
| gf_extra_height | float | 2 | |
| gf_magnet_d | 
| gf_magnet_height | 
| gf_embed_magnets | 
| gf_lid_top_grid | 
| gf_lid_bottom_grid | 
| gf_stacking_lip |

**Standard**

| Parameter Name | Value Type | Default Value | Description |
| --- | --- | --- | --- |
| std_width | 
| std_depth | 
| std_height | 
| roundness | 
| lip_height | 

**Label**

| Parameter Name | Value Type | Default Value | Description |
| --- | --- | --- | --- |
| label_width | 
| label_height | 

Parameters that you can configure:

Gridfinity vs Standard box
Stackable, creates a lip around the bottom so that a box can be stacked on a box of the same size
When generating a Gridfinity box, define size in terms of Gridfinity units
Select if you want to have magnet holes for the Gridfinity base (and magnet diameter), default size is 6x2mm magnets
When defining Standard box, define size by mm
Generate a flat label, text can be added by your favorite slicer
The scad library leverages the excellent Gridfinity Extended library to generate the Gridfinity specific components.