package com.tyyd.util;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class MyTest {

	public static void main(String[] args) {
		System.out.println(1L<<62);
//		Spliterator<Integer> rs = ls;
		// TODO Auto-generated method stub
//		System.out.println(~1);
//		DruidDataSourceConfig result = new DruidDataSourceConfig();
//		DruidDataSource ds =  new DruidDataSource();
//		ds.setConnectionInitSqls(connectionInitSqls);
//		int j = 0;
//		int i = j, s;
//		System.out.println(i);
//		Map<String, String> m = new HashMap<String, String>(16);
//		m.put("1", "2");
//		m.put("3", "4");
//		m.forEach((k, v) -> System.out.println(k + "=" + v));
		String ss = "Hello";

        String[] aa = ss.split("");

        String[] bb = {"H", "e", "l", "l", "o"};


        String[] strings = {"Hello", "World"};

        //Arrays.stream接收一个数组返回一个流
        List<Stream<String>> streamList = Arrays.asList(strings).stream().
                map(str -> str.split("")).
                map(str -> Arrays.stream(str)).
                collect(Collectors.toList());

        //分步写(map)

        Stream<String[]> stream = Arrays.asList(strings).stream().
                map(str -> str.split(""));

        Stream<Stream<String>> streamStream = stream.map(strings1 -> Arrays.stream(strings1));
        List<Stream<String>> streamList1 = streamStream.collect(Collectors.toList());


        List<String> stringList = Arrays.asList(strings).stream().
                map(str -> str.split("")).
                flatMap(str -> Arrays.stream(str))
                .collect(Collectors.toList());


        //分步写(流只能消费一次)(flatMap)
        Stream<String[]> stream1 = Arrays.asList(strings).stream().
                map(str -> str.split(""));

        Stream<String> stringStream = stream1.flatMap(strings1 -> Arrays.stream(strings1));

        List<String> stringList1 = stringStream.collect(Collectors.toList());

	}

}
