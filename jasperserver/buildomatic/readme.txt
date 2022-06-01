================================================================================
Product Name: TIBCO JasperReports Server Pro (TM)
Release Version: 8.0.2
Build version: [${Build_Version}]
Release Date: May 2022
================================================================================
Legal Notice

This Service Pack is provided pursuant to the terms and conditions of the
written maintenance and support agreement between you (or your company)
and TIBCO Jaspersoft; the use of the Service Pack is controlled by the terms of such
written maintenance and support agreement.
================================================================================
Introduction

This Service Pack should be applied to JasperReports Server Pro version [8.0.0] (with or
without installed cumulative hotfixes) or JasperReports Server Pro version [8.0.1]
(with or without installed cumulative hotfixes).
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
* JS-62936 [case 02035710] Buildomatic takes a very long time to export large number of users
* JS-64551 [case #02066165] - JSON validation error when refreshing a report
* JS-63364 Selecting cascading input controls values after scrolling resets position back to the top of list
* JS-64756 Upgrade Log4j to 2.17.1 version to fix CVE-2021-44228, CVE-2021-45046 and CVE-2021-45105
* JS-65348 [Case #2087115] Cannot save view if same field is used in measure and field calculations
* JS-65258 [case #02065852] - Data Chooser performance issue when clicking on "View as Tree"
* JS-65501 [case 02093962] Query generator creates aggregate expression for sum calculated field in the adhoc crosstab in 8.0.1 JRS
* JSS-3212 [case #02077765] Faulty email hyperlinks in tagged PDFs
* JS-65580 Resolve CVE-2022-22965 in JasperReports Server across all supported versions
* JS-65239 [case 02083861] Encode report export file names
* JS-65495 [case #2091501] JRS 8.0 IC fails to load when parameter value is injected from URL
* JS-56746 [case 01826463] Add "IF EXISTS" or "IF NOT EXISTS" to the MySQL upgrade scripts to the sections where something is deleted
* JS-64614 [case 01908246] XSS. Set default configuration in /WEB-INF/applicationContext-rest-services.xml to prevent browser rendering of the rest-api responses in html & xml format by restricting content type headers.

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

Details for fix JS-65258: When building a list of available data sources for Ad Hoc Views, the Data Chooser has to perform subqueries to filter out ad hoc reports and views stored under the /adhoc/topics location because only JRXML reports can be used as topics in Ad Hoc.
This subquery can be slow when there is a big number of ad hoc reports and views stored in the repository under that location. To improve performance, this subquery can be disabled by setting skip.adhoc.datasource.check=true in jasperserver-pro/WEB-INF/js.config.properties.
The only drawback is that if there are any ad hoc reports stored under /adhoc/topics, they will appear in Data Chooser List and Tree. Trying to use such an ad hoc report as a datasource in Ad Hoc (selecting it and clicking â€œChoose Data...â€œ) can lead to errors.
If skip.adhoc.datasource.check is enabled, please avoid using ad hoc reports as a datasource.

IMPORTANT: If previous hotfixes, service packs or recommendations with different versions of Log4j libraries were applied, then these Log4j libraries should be manually deleted. Please delete any Log4j files before applying(?) version 2.17.1.