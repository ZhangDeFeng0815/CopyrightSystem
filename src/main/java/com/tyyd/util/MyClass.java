package com.tyyd.util;

import java.time.Clock;
import java.time.DayOfWeek;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.Month;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.TreeSet;
import java.util.stream.Collectors;

public class MyClass {
	public void doSomething(String str) {   
        String[] args = new String[] {"microsoft","apple","linux","oracle"};
        Arrays.sort(args, Utils::compareByLength);
        System.out.println(111);
    }
	
	@FunctionalInterface
	interface Converter<F, T> {
		T convert(F from);
	}
	
	public static void main(String[] args) {
		MyClass my = new MyClass();
////		my.doSomething();
////		IntStream.rangeClosed(1,
////				 3).forEach(System.out::println);
//		Stream<List<Integer>> inputStream = Stream.of(
//				Arrays.asList(1),
//				Arrays.asList(2, 3),
//				Arrays.asList(4, 5, 6)
//		);
//
//		Stream<Integer> outputStream = inputStream.
//				flatMap((childList) -> childList.stream());
//		List<Integer> list = outputStream.collect(Collectors.toList());
//		System.out.println(list.size());
//		
//		Stream.of("one", "two", "three", "four")
//				.filter(e -> e.length() > 3)
//				.peek(e -> System.out.println("Filtered value: " + e))
//				.map(String::toUpperCase)
//				.peek(e -> System.out.println("Mapped value: " + e))
////				.peek(e->my.doSomething(e))
//				.collect(Collectors.toList());
		
		
		Converter<String, Integer> a = (from) -> Integer.valueOf(from);
		System.out.println(a.convert("1111"));
		Clock clock = Clock.systemDefaultZone();
		Instant instant = clock.instant();
		Date legacyDate = Date.from(instant);
		System.out.println(legacyDate);
		
		LocalTime late = LocalTime.of(23, 59, 59);
		System.out.println(late);       // 23:59:59
		
		
		LocalDateTime sylvester = LocalDateTime.of(2014, Month.DECEMBER, 31, 23, 59, 59);
		DayOfWeek dayOfWeek1 = sylvester.getDayOfWeek();
		System.out.println(dayOfWeek1);      // WEDNESDAY
		Month month = sylvester.getMonth();
		System.out.println(month);          // DECEMBER
		
		List<Person> javaProgrammers = new ArrayList<Person>() {
			private static final long serialVersionUID = 1L;

			{
				add(my.new Person("Elsdon", "Jaycob", "Java programmer", "male", 43, 2000));
				add(my.new Person("Tamsen", "Brittany", "Java programmer", "female", 23, 1500));
				add(my.new Person("Floyd", "Donny", "Java programmer", "male", 33, 1800));
				add(my.new Person("Sindy", "Jonie", "Java programmer", "female", 32, 1600));
				add(my.new Person("Vere", "Hervey", "Java programmer", "male", 22, 1200));
				add(my.new Person("Maude", "Jaimie", "Java programmer", "female", 27, 1900));
				add(my.new Person("Shawn", "Randall", "Java programmer", "male", 30, 2300));
				add(my.new Person("Jayden", "Corrina", "Java programmer", "female", 35, 1700));
				add(my.new Person("Palmer", "Dene", "Java programmer", "male", 33, 2000));
				add(my.new Person("Addison", "Pam", "Java programmer", "female", 34, 1300));
			}
		};
		TreeSet<String> javaDevLastName = javaProgrammers  
		          .stream()  
		          .map(Person::getLastName)  
		          .collect(Collectors.toCollection(TreeSet::new));
	}
	
	public class Person {

		private String firstName, lastName, job, gender;
		private int salary, age;

		public Person(String firstName, String lastName, String job, String gender, int age, int salary) {
			this.firstName = firstName;
			this.lastName = lastName;
			this.gender = gender;
			this.age = age;
			this.job = job;
			this.salary = salary;
		}

		public String getLastName() {
			return lastName;
		}

		public void setLastName(String lastName) {
			this.lastName = lastName;
		}

		public int getAge() {
			return age;
		}

		public void setAge(int age) {
			this.age = age;
		}
	}
}
