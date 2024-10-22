#ifndef LISTINGSTEST_H_
#define LISTINGSTEST_H_

#include <iostream>

class ListingsTest {
public:
    ListingsTest() {};
    ListingsTest(int testInt, float textFloat):
        TestStruct{testInt, textFloat} 
    {
        auto testAutoVar = testInt;
        bool testBool;
    };
    ~ListingsTest();

    void testPublicFunction();

protected:
    void testProtectedFunction();
    virtual void testVirtualFunction();
private:
    void testPrivateFunction();

    struct TestStruct {
        int testInt;
        float testFloat;
    } TestStruct;

    enum TestEnum {
        TEST_ENUM_1,
        TEST_ENUM_2,
        TEST_ENUM_3
    };
};

class ListingsTestChild : public ListingsTest {
public:
    ListingsTestChild();
    ~ListingsTestChild();

protected:
    void testPublicFunction();
    void testVirtualFunction() final override;
};

#endif