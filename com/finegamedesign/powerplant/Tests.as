package com.finegamedesign.powerplant
{
  import asunit.framework.TestSuite;

  public class Tests extends TestSuite
  {
    public function Tests()
    {
        addTest(new TestStack());
        addTest(new TestCalculate());
        addTest(new TestGame());
    }
  }
}
