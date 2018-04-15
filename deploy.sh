#!/bin/bash

# Configure user
git config --global user.email "travis@travis-ci.org"
git config --global user.name "Travis CI"

# decrypt SSH key
openssl aes-256-cbc -K $encrypted_960ca19ad916_key -iv $encrypted_960ca19ad916_iv -in key.enc -out key -d
# set correct permissions on key (ssh-add will decline it otherwise)
chmod 600 key
# start SSH agent
eval $(ssh-agent -s)
ssh-add key
# add remote using ssh
git remote add origin-ssh ssh://git@github.com/randomdude999/testing.git

git fetch --all # update repo

if [ "$(git rev-parse HEAD)" == "$(git rev-parse $TRAVIS_BRANCH)" ]; then
    # we are on the latest commit of the branch
    git checkout $TRAVIS_BRANCH # to get out of detached head
    git add . # add all modified files
    git commit --message "Automatically fix formatting using clang-format [ci skip]"

    # no need to do set-upstream since we won't be pulling from this remote again
    git push origin-ssh $TRAVIS_BRANCH
fi