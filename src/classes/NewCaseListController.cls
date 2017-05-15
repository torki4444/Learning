/**
 * Created by CIVCIZ on 08-May-17.
 */

public class NewCaseListController {

    public List<Case> getNewCases() {

        List<Case> results = [Select Id, caseNumber FROM Case Where Status = 'New'];

        return results;
    }
}