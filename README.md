# Parametric Box
 
A Gridfinity compatible parametric box that can be filled with Gridfinity bins and sizes of your choosing, you can configure the # of units (and height) from using the parametric configuration.  The sample sizes are 5x4x6u and 2x2x6u.  The bins are stackable and can be configured with Gridfinity bases on the outside to hook into your existing Gridfinity bases.

The generator is also capable of generating boxes that do not have the Gridfinity slots as well (and can be defined by a size of your choosing).

## Setup

Requirements:
- OpenSCAD nightly ("stable" version will not work)
- [Gridfinity Extended](https://github.com/ostat/gridfinity_extended_openscad) - clone repository into `./gridfinity-extended` folder, it will be referenced from the scad files in this repository

## Parameters

**General**

This properties control what parts are being rendered and general properties that apply regardless of part or type of box being generated.

| Parameter Name | Value Type | Default Value | Description |
| --- | --- | --- | --- |
| type | string | gridfinity | type of box to generate <br/>**options**: gridfinity, standard |
| component | string | box | which component to render <br/>**options**: box, lid, label |
| stackable | boolean | false | toggle for stacking lip on the bottom of the box, otherwise has a flat bottom |
| wall_thickness | float | 4 | thickness (mm) of the main body of the box |
| lid_thickness | float | 2 | thickness (mm) of the lid |
| bottom_wall_thickness | float | 2.4 | thickness (mm) of the bottom of the box, when not stackable |
| fudge | float | .3 | tolerance to add to parts to compensate for printing tolerances of your printer, larger selection gives more wiggle room <br/>**selection**: between 0-1 with .1 steps |

**Gridfinity**

These parameters apply specifically to Gridfinity boxes.

| Parameter Name | Value Type | Default Value | Description |
| --- | --- | --- | --- |
| gf_width | int | 5 | # of Gridfinity units wide |
| gf_depth | int | 5 | # of Gridfinity units deep |
| gf_height | int | 6 | # of Gridfinity units high |
| gf_extra_height | float | 2 | additional height (mm) to add to the height, useful to provide additional space above bins or account for various height differences of bins.  Default value of 2 seemed to work for most bins printed |
| gf_magnet_d | float | 6.1 | magnet diameter if you wish to incorporate magnet holes for Gridfinity base/bins <br/> **selection**: between 0-7 with .1 steps |
| gf_magnet_height | float | 2 | magnet hole height for Gridfinity base/bins <br/> **selection**: 0-3 with .1 steps 
| gf_embed_magnets | boolean | false | toggle to enable magnet holes |
| gf_lid_top_grid | boolean | false | add a Gridfinity base to the top of the lid |
| gf_lid_bottom_grid | boolean | true | add a Gridfinity base to the bottom of the box, uesful if stacking with other boxes to prevent bins from spilling |
| gf_stacking_lip | boolean | true | option to turn off the lip so the box can be stacked into existing Gridfinity bases |

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