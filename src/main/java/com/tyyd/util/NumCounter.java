package com.tyyd.util;

public class NumCounter {
	private int num;
	private int sum;
	// 是否当前是个完整的数字
	private boolean isWholeNum;

	public NumCounter(int num, int sum, boolean isWholeNum) {
		this.num = num;
		this.sum = sum;
		this.isWholeNum = isWholeNum;
	}

	public NumCounter accumulate(Character c) {
		System.out.println(Thread.currentThread().getName());
		if (Character.isDigit(c)) {
			return isWholeNum ? new NumCounter(Integer.parseInt("" + c), sum, false)
					: new NumCounter(Integer.parseInt("" + num + c), sum, false);
		} else {
			System.out.println("sum = " + sum);
			System.out.println("num = " + sum);
			return new NumCounter(0, sum + num, true);
		}
	}

	public NumCounter combine(NumCounter numCounter) {
		System.out.println("this.getSum() = " + this.getSum());
		System.out.println("numCounter.getSum() = " + numCounter.getSum());
		return new NumCounter(0, this.getSum() + numCounter.getSum(), numCounter.isWholeNum);
	}

	public int getSum() {
		return sum + num;
	}
}
