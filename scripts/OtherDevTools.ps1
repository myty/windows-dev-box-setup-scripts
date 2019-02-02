#--- Fonts ---
choco install -y inconsolata
choco install -y firacode

#--- Tools ---
choco install -y git-credential-manager-for-windows
choco install -y powershell-core
choco install -y jdk8
choco install -y rust
choco install -y golang
choco install -y ngrok.portable
choco install -y sudo

#--- Apps ---
choco install -y fiddler
choco install -y hyper
choco install -y conemu
choco install -y cmder
choco install -y windirstat
choco install -y sql-server-management-studio
choco install -y insomnia-rest-api-client
choco install -y filezilla

#-------------------------------------------------
# WEB TOOLS
#-------------------------------------------------
choco install -y IIS-WebServerRole -source windowsFeatures

#--- Tools ---
code --install-extension msjsdiag.debugger-for-chrome
code --install-extension msjsdiag.debugger-for-edge

#--- Tools ---
choco install -y nodejs
choco install -y yarn
choco install -y python2 # Node.js requires Python 2 to build native modules