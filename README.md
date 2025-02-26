# CollegeMap
## For Backend 
### Run following command on your linux terminal to install dependacies
    sudo apt update
    sudo apt install -y git curl libssl-dev libreadline-dev zlib1g-dev \
    autoconf bison build-essential libyaml-dev libreadline-dev libncurses5-dev \
    libffi-dev libgdbm-dev libpq-dev postgresql postgresql-contrib

### Add rbenv to PATH
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
    echo 'eval "$(rbenv init -)"' >> ~/.bashrc
    source ~/.bashrc

### Install ruby-build
    mkdir -p "$(rbenv root)"/plugins
    git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build

### install ruby 
    rbenv install 3.4.2

### Set the global Ruby version
    rbenv global 3.2.2

### enable postgres service
    sudo systemctl enable postgresql

### switch to postgres user and set password
    sudo -i -u postgres psql
    ALTER USER WITH PASSWORD 'your_secure_password';
    \q