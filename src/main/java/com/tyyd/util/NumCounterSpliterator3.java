package com.tyyd.util;

import java.util.Spliterator;
import java.util.function.Consumer;

public class NumCounterSpliterator3 implements Spliterator<Character> {
	private char[] str;
	private int currentChar = 0;
	private int end = Integer.MAX_VALUE;
	private boolean canSplit = true;

	public NumCounterSpliterator3(int currentChar, int end, char[] str, boolean canSplit) {
		this.str = str;
		this.currentChar = currentChar;
		this.canSplit = canSplit;
		this.end = end;
	}

	@Override
	public boolean tryAdvance(Consumer<? super Character> action) {
		action.accept(str[currentChar++]);
		return currentChar < end;
	}

	@Override
	public Spliterator<Character> trySplit() {
		int i = currentChar;
		int currentCharOld = currentChar;
		for (; canSplit && i <= end; ++i) {
			if (!Character.isDigit(str[i])) {
				int splitBeforeEnd = end;
				canSplit = false;
				if (i + 1 <= splitBeforeEnd) {
					currentChar = i + 1;
					return new NumCounterSpliterator3(currentCharOld, i, str, true);
				} else {
					return null;
				}
			}
		}

		canSplit = false;
		return null;
	}

	@Override
	public long estimateSize() {
		return end - currentChar;
	}

	@Override
	public int characteristics() {
		return ORDERED | SIZED | SUBSIZED | NONNULL | IMMUTABLE;
	}
}
