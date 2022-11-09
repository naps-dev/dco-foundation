# Defensive Cyber Operations Foundation

## BigBang Upgrade Process
Tentative instructions for upgrading the version of Bigbang included in the zarf package. This only addresses how to update the zarf package -- additional consideration will be needed for updating any existing deployments.

Instructions:
* Update Bigbang repository URL reference tags in:
  * `./kustomizations/bigbang/kustomization.yaml`
  * `./zarf.yaml`
* View the [Bigbang release notes](https://repo1.dso.mil/platform-one/big-bang/bigbang/-/releases) for the target version ([example -- 1.46.0](https://repo1.dso.mil/platform-one/big-bang/bigbang/-/releases/1.46.0))
* Adjust the version tags in `components.big-bang-core-standard-assets.repos`  according to the version shown in the `BB Version` column of the "Packages" table in the release notes
* Use `zarf prepare find-images --repo-chart-path "chart/"` to identify the list of images required for the target packages
* Update the component `images` according to the output of `zarf prepare`^
* test test test