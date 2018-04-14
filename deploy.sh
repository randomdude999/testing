git config --global user.email "travis@travis-ci.org"
git config --global user.name "Travis CI"

# git checkout -b master
git add test_file_$TRAVIS_BUILD_NUMBER
git commit --message "Travis build: $TRAVIS_BUILD_NUMBER"

# echo Key: $encrypted_46195950b351_key
# echo IV: $encrypted_46195950b351_iv

# openssl aes-256-cbc -K $encrypted_46195950b351_key -iv $encrypted_46195950b351_iv -in key.enc -out key -d
openssl aes-256-cbc -K $encrypted_960ca19ad916_key -iv $encrypted_960ca19ad916_iv -in key.enc -out key -d
eval $(ssh-agent -s)
chmod 600 key
ssh-add key 

git remote add origin-asdf ssh://git@github.com/randomdude999/testing.git
git push --set-upstream origin-asdf master
