echo "plugin_cache_dir=\"$HOME/.terraform.d/plugin-cache\"" >~/.terraformrc
echo "credentials \"app.terraform.io\" {\ntoken = $TF_API_TOKEN \n}" >> ~/.terraformrc
mkdir --parents ~/.terraform.d/plugin-cache