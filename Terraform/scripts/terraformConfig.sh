echo "plugin_cache_dir=\"$HOME/.terraform.d/plugin-cache\"" >~/.terraformrc
echo -e "credentials \"app.terraform.io\" {\ntoken = \"$TF_API_TOKEN\" \n}" >> ~/.terraformrc
mkdir --parents ~/.terraform.d/plugin-cache
cat ~/.terraformrc