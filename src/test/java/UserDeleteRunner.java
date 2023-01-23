import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

public class UserDeleteRunner {
    @Test
    public void testParallel(){
        Results results = Runner.path("classpath:features/users/delete/user-delete.feature"
                )
                .outputCucumberJson(true)
                .tags("~@ignore")
                .parallel(1);
        generateReport(results.getReportDir());
        Assertions.assertTrue(results.getFailCount()==0,results.getErrorMessages());
    }

    public void generateReport(String karateOuthPath){
        Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOuthPath), new String[]{"json"}, true);
        List<String> jsonPaths = new ArrayList<>(jsonFiles.size());
        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
        Configuration config = new Configuration( new File("target"), "Test delete");
        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths,config);
        reportBuilder.generateReports();
    }
}


