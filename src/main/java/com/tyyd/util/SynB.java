package com.tyyd.util;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

public class SynB {
	private static final SynA a = new SynA();
	public void method1() throws InterruptedException {
        synchronized (a) { //直接进行加锁
        	System.out.println(Thread.currentThread().getName());
        	Thread.sleep(10000L);
        	a.method1();
        	System.out.println(Thread.currentThread().getName() + "end");
        }
    }

	public static void main(String[] args) {
//		for (int i=0;i<10;i++) {
//			new Thread(() -> {
//				SynB b = new SynB();
//				try {
//					b.method1();
//				} catch (InterruptedException e) {
//					e.printStackTrace();
//				}
//			}).start();
//		}
		/** 获取单词，并且去重 **/
//		List<String> list = Arrays.asList("hello welcome", "world hello", "hello world", "hello world welcome");
//
//		// map和flatmap的区别
//		list.stream().map(item -> Arrays.stream(item.split(" "))).distinct().collect(Collectors.toList())
//				.forEach(System.out::println);
//		System.out.println("---------- ");
//		list.stream().flatMap(item -> Arrays.stream(item.split(" "))).distinct().collect(Collectors.toList()).forEach(System.out::println);
		
		
//		List<Integer> nums = Arrays.asList(1, 1, null, 2, 3, 4, null, 5, 6, 7, 8, 9, 10);
//		List<Integer> numsWithoutNull = nums.stream().filter(num -> num != null).collect(() -> new ArrayList<Integer>(),
//				(list, item) -> list.add(item), (list1, list2) -> list1.addAll(list2));
//		
//		List<Integer> numsWithoutNull1 = nums.stream().filter(num -> num != null).collect(Collectors.toList());
//		numsWithoutNull.forEach(System.out::println);
		System.out.println(1<<0);
//		Array.newInstance(String.class, 9);
	}
	
	public static <T extends Throwable> void doWork(T t) throws T {
	    try {
	    } catch (Throwable realCause) {
	        t.initCause(realCause);
	        throw t;
	    }
	}

}
