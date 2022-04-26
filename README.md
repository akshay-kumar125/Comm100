# Cucumber Practice

## About

This is just for some cucumber practice.

## Getting started



#### Execution

we can also generate the nice html test execution report using below command with 'bundle exec cucumber'

```
['--format html --out Automation_Report.html --format pretty']
```

we can run the specific test using tags on scenarios using --tag @tag-name. e.g. 

```
`bundle exec cucumber --tag @tag-name`
```

we can run the test for specific profile using --profile=@profile. e.g. 

```
`bundle exec cucumber --tag @tag-name --profile=browserstack`
```


## Writing features

A single feature file will usually describe an aspect of the site for example "Authentication", the ability to sign in and out when valid details are supplied.

The feature files themselves will consist of a feature description at the top of the file, this is of no real impact to the execution of a feature it is just to describe what the feature is about for the reader's sake e.g.

```
Feature: comm100 Authentication
  In order to Verify Dashboard
  As an existing User
  I want to be able to sign in
```

And then a number of scenarios which are executable and perform the actual tests:

```
  Scenario: Users signs in with incorrect details
    Given I am on the home page
    When I attempt to sign in with incorrect account details
    Then I should see "Invalid username or password supplied"
```

The `Scenario:` line gives the description of the scenario, and then is followed by a number of "Steps". Steps are the executable parts and will match against step definitions (see the `features/step_definitions` directory).

A step will begin with:

 * Given
 * When
 * Then
 * And
 * But

Which you use makes no difference to the execution or the matched step definition, they are simply to give you a structured language which the software can execute.

### Writing steps

When you try and run steps which don't have a matching definition, you will find the console output will give you an example of the definition you should add e.g.

```
Given 'I am on the home page' do
  pending
end
```

Where `pending` tells the tests that the definition has not yet been implemented and to stop running the current scenario.

You can then use "Capybara" to describe what the definition should do, for instance with the above we would simply tell Capybara to visit the Comm100 homepage which leaves us with:

```
Given 'I am on the home page' do
  visit 'https://www.comm100.com/'
end
```
