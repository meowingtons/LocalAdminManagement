# LocalAdminManagement
Like LAPS, but for the Local Administrators group.

Managing the built-in Administrators group on lots (100+) of domain joined Windows machines is irritating if different teams manage subsets of the overall environment. Theoretically, a GPO for each group that needs access could work. After a certain point, that gets unwieldy and difficult to report on. This set of scripts/services uses AD attributes attached to the computer object to manage the Administrators group. By using AD attributes, existing tooling (ADUC, AD Cmdlets, ADSI, etc.) can be leveraged to make it easy to report on and edit. A service on the machines keeps these attributes and the local group in sync. 

Additionally, accurate reporting of every machines Administrators membership is not easy. This script dumps the current membership into another attribute on the computer object. Getting a dump of current membership is as simple as "get-adcomputer -filter * -properties lamCurrentAdminMembers".
