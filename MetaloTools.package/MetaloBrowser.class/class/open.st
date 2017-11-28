instance creation
open 

<example>
"self open"

| registry nav b |

registry := MLModuleExample new systemSupportRulesModuleExample.

nav  := ClySystemNavigationEnvironment over: registry.

b :=ClySystemBrowser openOn: nav.
b plugins removeAll.
b addPlugin: ClyStandardBrowserPlugin new