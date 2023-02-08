echo "plugin_cache_dir=\"$HOME/.terraform.d/plugin-cache\"" >~/.terraformrc
echo -e "credentials \"app.terraform.io\" {\ntoken = iAhLCFemCeK37g.atlasv1.qPgrIhVDlJesG8MIyP4Gyx4KIjluRJUZet7T4QWrPmSuOy0jidzdaz3EJVlLZvMil7I \n}" >> ~/.terraformrc
mkdir --parents ~/.terraform.d/plugin-cache