/**
 * 
 */
package com.test.fileSystem;


/**
 * @author Wayne.Wang<5waynewang@gmail.com>
 * @since 5:42:46 PM Feb 19, 2014
 */
public class BaseTest {

	static public void assertEquals(long expected, long actual) {
		if (expected != actual) {
			throw new RuntimeException(expected + " != " + actual);
		}
	}

	static public void assertEquals(boolean expected, boolean actual) {
		if (expected != actual) {
			throw new RuntimeException(expected + " != " + actual);
		}
	}

	static public void assertEquals(String expected, String actual) {
		if ((expected == null && actual != null) || (expected != null && actual == null)
				|| (expected != null && actual != null && !expected.equals(actual))) {
			throw new RuntimeException(expected + " != " + actual);
		}
	}

	static public void assertEquals(Object expected, Object actual) {
		if (expected != actual) {
			throw new RuntimeException(expected + " != " + actual);
		}
	}
}
