================================================================================
Product Name: TIBCO JasperReports Server Pro (TM)
Release Version: ${JRS_Version}
Build version: [${Build_Version}]
Release Date: Dec 2022
================================================================================
Legal Notice

This Service Pack is provided pursuant to the terms and conditions of the
written maintenance and support agreement between you (or your company)
and TIBCO Jaspersoft; the use of the Service Pack is controlled by the terms of such
written maintenance and support agreement.
================================================================================
Introduction

This Service Pack should be applied to JasperReports Server Pro version [8.1.0] (with or
without installed cumulative hotfixes)
================================================================================
Installation

To apply the Service Pack:
* Find the JRS installer folder (e.g. c:\Users\jrs-user\jasperreports-server-x.x.x).
* Make a backup copy of that folder to a new, separate location.
* Delete the files listed in the section "Deleted files" from the installer files structure.
* Extract files (with full paths) from the Service Pack to the installer folder.
* At this point you may proceed with the install, upgrade or other operation which you have planned to execute
================================================================================
Uninstallation

To uninstall the Service Pack:
* Find the JRS installer folder (e.g. c:\Users\jrs-user\jasperreports-server-x.x.x).
* Delete everything from that folder (e.g. c:\Users\jrs-user\jasperreports-server-x.x.x\*.*)
* Find the backup of "jasperreports-server-x.x.x", that you created before installing this Service Pack, and copy all files from that folder into your web application directory (e.g. c:\Users\jrs-user\jasperreports-server-x.x.x)
================================================================================
Closed Issues

The Service Pack addresses the following issues(s):
* JS-66373 - Visualize.JS keeps authenticating with same credentials even if they have been changed
* JS-66441 Visualize.js - running Dashboard with configured non-US (non-default) date filter shows "Specify a valid value for type Date."
* JS-66422 In 8.0 the initial full page Loading message is no longer shown
* JS-66831 Client side code of Ad Hoc Designer and Viewer should check "Content-Type: application/repository.adhocDataView" header in case-insensitive mode
* JS-67000 Upgrade pgjdbc for CVE-2022-3119
* JS-66757 commons-configuration2 JAR flagged for critical CVE-2022-33980
* JS-67139 restricting JNDI service name to not allow ldap://host
* JS-66745 - removing Xalan dependency (using saxon for xslt)
* JS-65388 - upgrading Apache FOP to version 2.7
* JS-67275 missing validation for Dashlets url
* JS-67268 upgrading commons-text to version 1.10.0 to address CVE-2022-42889

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
