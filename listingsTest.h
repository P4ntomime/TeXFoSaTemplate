#ifndef LISTINGSTEST_H_
#define LISTINGSTEST_H_

#include <iostream>

class ListingsTest {
public:
    ListingsTest();
    ~ListingsTest();

    void testPublicFunction();

protected:
    void testProtectedFunction();

private:
    void testPrivateFunction();

    struct TestStruct {
        int testInt;
        float testFloat;
    };

    enum TestEnum {
        TEST_ENUM_1,
        TEST_ENUM_2,
        TEST_ENUM_3
    };
};

#endif