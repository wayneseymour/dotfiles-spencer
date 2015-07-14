#!/usr/bin/env bash

if [ ! -d ~/.ssh_test ]; then
  info 'generating ssh keys and config file'

  user 'What is your email address?'
  read -e email

  user 'Now, pick a password that you will have to live with'
  line 'for the rest of your life. Make it long and weird, but'
  line 'forget about l33t sp34k.'
  line ''
  line 'bad: Ycow)843('
  line 'okay: Pine82_sugar_Syrup'
  line 'best: spongeinasubmergedpinapplebyarock'
  echo ''

  pass=''
  asked_once=''
  while [ "${#pass}" -lt 20 ]; do
    if [ -z "$asked_once" ]; then
      asked_once='1'
    else
      info 'you can do better than that, try again'
    fi

    user ''
    read -e pass
  done

  info "alright, your password is set to $pass. Write that down and put it in your wallet."
  line "DO NOT STORE IT ONLINE!!!"
  echo ''
  echo ''

  mkdir ~/.ssh_test
  cat << EOF > ~/.ssh_test/config
Host *
  ServerAliveInterval 60
EOF
  ssh-keygen -t rsa -C "$email" -f ~/.ssh_test/id_rsa -N "$pass"
fi