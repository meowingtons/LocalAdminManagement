# LocalAdminManagement
Like LAPS, but for the Local Administrators group.

Managing the built-in Administrators group on domain joined Windows machines is irritating if you have a lot of machines that need different members. You could theoretically have a GPO for each group that needs access, but that gets unwieldy after 15+ teams. This set of scripts/services uses AD attributes attached to the computer object to manage the Administrators group. By using AD attributes, existing tooling (ADUC, AD Cmdlets, ADSI, etc.) makes it easy to report on and edit. A Windows service that runs on the machines you wish to manage/report on updates these attributes and the group on the local PC to keep everything in sync.

Additionally, trying to get an accurate report of every machines membership of Administrators is not easy. This script dumps the current membership into another attribute attached to the computer object. Getting a dump is as simple as "get-aduser -filter * -properties lamCurrentAdminMembers".
