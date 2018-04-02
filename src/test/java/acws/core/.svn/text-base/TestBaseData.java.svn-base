package acws.core;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.tyyd.framework.core.dao.impl.BaseDaoImpl;
import com.tyyd.framework.core.util.BaseDataUtils;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath*:acws.xml"})
public class TestBaseData extends BaseDaoImpl{
	/**
	 * 指定表名
	 * 一张表对应一个Dao
	 */
	@Override
	public String getTableName() {
		return "BO_DB_TEST";
	}

	/**
	 * 指定数据源Id
	 * 当前数据库为默认数据库时可以省略该函数
	 */
	@Override
	public String getDataSourceId() {
		return "dsAcwsH2";
	}

	@Test
	public void test001(){
		System.out.println(BaseDataUtils.getBaseDataDetailList("1"));;
	}
	@Test
	public void test002(){
		System.out.println("h2path");
		System.out.println(System.getenv("h2path"));
		System.out.println(System.getenv("JBOSS_HOME"));
		System.out.println(System.getProperties());
		System.out.println(System.getenv());
	}
	
	
}