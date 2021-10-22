================================================================================
Introduction

This is the readme for the JasperReports Server buildomatic installation and configuration tool.
This Service Pack should be applied to JasperReports Server Pro version 7.8.0.
Build version [${Build_Version}].
================================================================================
Installation

To apply the Service Pack:
* Find the JRS installer folder (e.g. c:\Users\jrs-user\jasperreports-server-x.x.x).
* Make a backup copy of that folder to a new, separate location.
* Delete the files listed in the section "Deleted files" from the installer files structure.
* Extract files (with full paths) from the hotfix to the installer folder.
* At this point you may proceed with the install, upgrade or other operation which you have planned to execute
================================================================================
Uninstallation

To uninstall the Service Pack:
* Find the JRS installer folder (e.g. c:\Users\jrs-user\jasperreports-server-x.x.x).
* Delete everything from that folder (e.g. c:\Users\jrs-user\jasperreports-server-x.x.x\*.*)
* Find the backup of "jasperreports-server-x.x.x", that you created before installing this Service Pack, and copy all files from that folder into your web application directory (e.g. c:\Users\jrs-user\jasperreports-server-x.x.x)
================================================================================
Closed Issues

This Service Pack addresses the following issues(s):
* JS-34822 [case #01796955] HTTP API: mandatory IC assigns first value to parameter regardless of user input; output=pdf only
* JS-59254 Always Prompt Input Control Flag not Working
* JS-59259 Dashboard:Visualize: Parameter mapping is broken in Sample Dashboard 3.1_Sales_Metrics
* JS-59480 A cache issue exists which prevents the visualize.js code to display correctly
* JS-59321 [case #1891086] JRS 7.5 Single Select IC Display Problem in Firefox (v79)
* JS-59736 [case 01897036] domain involving 2 schemas with same table name results in import error and dup fields
* JS-59450 Scheduled Report Parameters not Saving
* JS-59709 Report execution failed with cascade input control error in JRS 7.8.0
* JS-60148 Dashboard hyperlink is not working in VisualizeJS
* JS-34299 [case 01651927 + 1] Scheduler - Dashboard does not refresh dependent input controls in a cascade when master control is changed
* JS-59998 [Case #1900719] Import into a different Org via GUI fails due to a missing keyAlias value
* JS-59935 Following cascading Input Controls loses its values after selecting 2nd Input Control value
* JS-60101 Scheduler: Unable to edit and save scheduler job when report name changed
* JS-60104 Report Option, Scheduler: Incorrect saved value when run report option in background or scheduled
* JS-60302 [case 01906277] Reports with parameter name that matches the domain field name do not run on the server
* JS-59935 Following cascading Input Controls loses its values after selecting 2nd Input Control value
* JS-60187 Input Control parameter value passed via URL are not effected on drill through report that has query-based input control
* JS-60169 [case 01902529] 7.8 cascading IC problem with more than 100 items in query
* JS-60046 Depended cascading input control does not keep its value after updating parent control's value
* JS-59995 Update MasterPropertiesObfuscator to split propsToEncrypt by a comma
* JS-60806 [case 01917547] latest hotfix of 7.8.0 breaks edit parameter tab in schedule for some reports
* JS-60735 [Case #1912641] Ad Hoc View hangs in Dashboard with is-one-of filter
* JS-60861 [Case #01916103] configs in applicationContext-rest-services.xml result in blank page and javascript console errors upon upgrade to 7.8
* JS-60707 [Case #1914345] Intermittent P{LoggedInUser}.getTenantId() failure due to collision
* JS-60758 Visualize.js: chart dashlet hyperlink doesn't work
* JS-60776 [Case - 01917256 ] Search box text in input control does not clear after clicking reset
* JS-61020 [case 01922230] Value of incorrect data type gets passed to a cascading control causing previously working queries to not work anymore
* JS-60751 [Case - 01913590 ] Tibco Maps Hyperlink including path of Jasper Server
* JS-61191 [case 01926425] Search inside a filter doesn't work in Dashboard
* JS-61626 [case 01921857] CORS error with CAS server
* JS-61565 [Case - 01931686 ] Input control filter deselect is working inappropriately in JRS 7.9.0
* JS-61688 [case 01931789] deselect button in multi-select for report isn't resetting values as of 7.8, 7.9
* JS-61867 [case 01937391 ] visualize validation regression in 7.8
* JS-58467 [case 01865644] Javascript validation doesn't allow CTE WITH in the start of queries in Derived tables
================================================================================
Added files:
${Added_Files}
================================================================================
Modified files:
${Modified_Files}
================================================================================
Deleted files:
${Delete_Files}
================================================================================
Additional Notes:
In order to apply fix for JS-60302 [case 01906277] "Reports with parameter name that matches the domain field name do not run on the server",
or to disable report parameters validation for all jrxml based reports in general
you need to modify "/<jasperserver-pro-location>/WEB-INF/applicationContext-adhoc.xml", find "baseAdhocQueryValidator" bean definition and set "validateReportParameters" to be "false"