package acws.core;

import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.tyyd.crps.scf.demo.service.ScfDemoService;
import com.tyyd.framework.core.soa.ScfAdapter;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath*:acws_test.xml"})
public class TestAsSpring{

	@Test
	public void test001(){
		com.yutian.statistics.StatLog a;
		ScfDemoService scfDemoService = (ScfDemoService)ScfAdapter.getInstance("scfDemoService");
		Map<String, Object>  outputData = scfDemoService.wellcome("小明");
		System.out.println(outputData);
	}
}