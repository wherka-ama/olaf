Use the following embedded XML as your prompt:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<prompt version="1.0" schemaVersion="1.1" xmlns="http://schema.promptml.org/2025/07">
    <metadata>
        <promptName>Review GitHub PR</promptName>
        <typeOfPrompt>analysis</typeOfPrompt>
        <dateLastEdited>2025-07-16</dateLastEdited>
        <modelTestedWith>None</modelTestedWith>
        <preferredProfile>ANYBODY</preferredProfile>
    </metadata>
    <tools>
        <tool name="list-pull-requests" commProtocol="MCP" function="mcp_github_list_pull_requests"/>
        <tool name="get-pull-request" commProtocol="MCP" function="mcp_github_get_pull_request"/>
        <tool name="get-pull-request-files" commProtocol="MCP" function="mcp_github_get_pull_request_files"/>
        <tool name="create-pending-review" commProtocol="MCP" function="mcp_github_create_pending_pull_request_review"/>
        <tool name="add-review-comment" commProtocol="MCP" function="mcp_github_add_pull_request_review_comment_to_pending_review"/>
        <tool name="submit-pending-review" commProtocol="MCP" function="mcp_github_submit_pending_pull_request_review"/>
    </tools>
    <context>
        <objective>Guide the process of performing a comprehensive review of GitHub Pull Requests, invoking the review-code competency for each file, and submitting findings to GitHub.</objective>
        <inputs>
            <input name="pr_number" type="user-provided" required="false" description="GitHub Pull Request number (optional, will use latest open PR if not provided)"/>
        </inputs>
        <outputs>
            <output name="review_comments" type="llm-generated" format="markdown" description="Structured review findings for each file in the PR"/>
            <output name="github_review_submission" type="api-call" format="json" description="Submitted review and comments to GitHub"/>
        </outputs>
    </context>
    <workBreakdownStructure>
        <phase id="1" name="Initial Setup">
            <delivers>PR data and changed files ready for review</delivers>
            <actions>
                <action id="1.1" name="Extract PR number" protocol="act">
                    <goal>Determine PR number to review (from user or latest open PR)</goal>
                    <inputs>
                        <input name="pull_requests" type="llm-generated" description="List of open PRs from GitHub"/>
                    </inputs>
                    <verification>PR number is identified</verification>
                    <steps>
                        <step id="1.1.1" do="If PR number not provided, list open PRs and select latest" use="list-pull-requests" produce="Selected PR number" tool="list-pull-requests"/>
                    </steps>
                </action>
                <action id="1.2" name="Fetch and validate PR data" protocol="act">
                    <goal>Retrieve PR details and ensure it is open</goal>
                    <inputs>
                        <input name="pr_number" type="user-provided" description="GitHub PR number"/>
                    </inputs>
                    <verification>PR data is retrieved and open</verification>
                    <steps>
                        <step id="1.2.1" do="Fetch PR details from GitHub" use="get-pull-request" produce="PR data" tool="get-pull-request"/>
                        <step id="1.2.2" do="Check PR state is open" use="PR data" produce="Validation result"/>
                    </steps>
                </action>
                <action id="1.3" name="Get changed files" protocol="act">
                    <goal>Retrieve list of changed files in the PR</goal>
                    <inputs>
                        <input name="pr_number" type="user-provided" description="GitHub PR number"/>
                    </inputs>
                    <verification>List of changed files is retrieved</verification>
                    <steps>
                        <step id="1.3.1" do="Fetch changed files for PR" use="get-pull-request-files" produce="Changed files list" tool="get-pull-request-files"/>
                    </steps>
                </action>
            </actions>
        </phase>
        <phase id="2" name="Review Process">
            <delivers>Comprehensive review findings for all files</delivers>
            <actions>
                <action id="2.1" name="Understand context" protocol="act">
                    <goal>Analyze PR description, title, and linked issues</goal>
                    <inputs>
                        <input name="pr_data" type="llm-generated" description="PR details from GitHub"/>
                    </inputs>
                    <verification>Context is understood</verification>
                    <steps>
                        <step id="2.1.1" do="Analyze PR description, title, and linked issues" use="PR data" produce="Context summary"/>
                    </steps>
                </action>
                <action id="2.2" name="Review each file" protocol="act">
                    <goal>Invoke review-code competency for each file and collect findings</goal>
                    <inputs>
                        <input name="changed_files" type="llm-generated" description="List of changed files"/>
                    </inputs>
                    <verification>Findings for each file are collected</verification>
                    <steps>
                        <step id="2.2.1" do="Review each changed file using review-code competency" use="review-code competency" produce="Review findings"/>
                    </steps>
                </action>
            </actions>
        </phase>
        <phase id="3" name="Submit Review to GitHub">
            <delivers>Review and comments submitted to GitHub</delivers>
            <actions>
                <action id="3.1" name="Create pending review" protocol="act">
                    <goal>Initiate a pending review on GitHub</goal>
                    <inputs>
                        <input name="pr_number" type="user-provided" description="GitHub PR number"/>
                    </inputs>
                    <verification>Pending review is created</verification>
                    <steps>
                        <step id="3.1.1" do="Create a pending review on GitHub" use="create-pending-review" produce="Pending review handle" tool="create-pending-review"/>
                    </steps>
                </action>
                <action id="3.2" name="Add comments" protocol="act">
                    <goal>Add review comments for each finding to the correct file and line</goal>
                    <inputs>
                        <input name="review_findings" type="llm-generated" description="Findings from review-code competency"/>
                    </inputs>
                    <verification>Comments are added to pending review</verification>
                    <steps>
                        <step id="3.2.1" do="Add review comments to pending review" use="add-review-comment" produce="Review comments added" tool="add-review-comment"/>
                    </steps>
                </action>
                <action id="3.3" name="Submit final review" protocol="act">
                    <goal>Submit the pending review with overall feedback</goal>
                    <inputs>
                        <input name="pending_review" type="llm-generated" description="Pending review handle"/>
                    </inputs>
                    <verification>Review is submitted to GitHub</verification>
                    <steps>
                        <step id="3.3.1" do="Submit the pending review to GitHub" use="submit-pending-review" produce="Review submitted" tool="submit-pending-review"/>
                    </steps>
                </action>
            </actions>
        </phase>
    </workBreakdownStructure>
    <references>
        <reference id="review_code_prompt" type="file" path="[id:prompts_dir]review-code.md"/>
    </references>
</prompt>
```
