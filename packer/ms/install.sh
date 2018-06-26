function set_locales(){
  mv /etc/default/locales /etc/default/locales.tmp  
  cp locales /etc/default/locales
}

function install_metaspolit(){
  curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && \
    chmod 755 msfinstall && \
    ./msfinstall
}

function configure_db(){
  msfdb init
}

set_locales
install_metaspolit
configure_db

