echo "Testing" > test_file_$TRAVIS_BUILD_NUMBER
if [ "$test1" == "fail" ]; then
    exit 1
fi