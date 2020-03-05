# Contributing to the ConnectWiseManage PowerShell REST API Wrapper

:+1::tada: First off, thanks for taking the time to contribute! :tada::+1:

The following is a set of guidelines for contributing. These are mostly guidelines, not rules. Use your best judgment, and feel free to propose changes to this document, or anything else in a pull request.

## Table Of Contents

[I don't want to read this whole thing, I just have a question!!!](#i-don't-want-to-read-this-whole-thing-i-just-have-a-question)

[How Can I Contribute?](#how-can-i-contribute)

-   [Reporting Bugs](#reporting-bugs)
-   [Suggesting Enhancements](#suggesting-enhancements)
-   [Your First Code Contribution](#your-first-code-contribution)
-   [Pull Requests](#pull-requests)

[Styleguides](#styleguides)

-   [Git Commit Messages](#git-commit-messages)
-   [Powershell Styleguide](#powershell-styleguide)
-   [Documentation Styleguide](#documentation-styleguide)

## I don't want to read this whole thing I just have a question

> **Note:** *Please don't file an issue to ask a question.* You'll get faster results by using the resources below.

Join the MSPGeek Slack team:

-   [Join the MSPGeek Slack Team](https://join.mspgeek.com/)
    -   Even though Slack is a chat service, sometimes it takes several hours for community members to respond — please be patient!
    -   Use the `#cw-manage` channel for general questions or discussion
    -   There are many other channels available, check the channel list

## How Can I Contribute

### Reporting Bugs

This section guides you through submitting a bug report. Following these guidelines helps maintainers and the community understand your report :pencil:, reproduce the behavior :computer: :computer:, and find related reports :mag_right:.

Before creating bug reports, please check existing issues as you might find out that you don't need to create one. When you are creating a bug report, please include as many details as possible. Fill out template, the information it asks for helps us resolve issues faster.

> **Note:** If you find a **Closed** issue that seems like it is the same thing that you're experiencing, open a new issue and include a link to the original issue in the body of your new one.

#### Before Submitting A Bug Report

-   **Check the Wiki.** You might be able to find the cause of the problem and fix things yourself.
-   **Check the [MSPGeek Slack Team](https://join.mspgeek.com/)** for help from the community.

#### How Do I Submit A (Good) Bug Report

Bugs are tracked as [GitHub issues](https://guides.github.com/features/issues/). After you've determined which repository your bug is related to, create an issue on that repository and provide the following information by filling in the template.

Explain the problem and include additional details to help maintainers reproduce the problem:

-   **Use a clear and descriptive title** for the issue to identify the problem.
-   **Describe the exact steps which reproduce the problem** in as many details as possible.
-   **Provide specific examples to demonstrate the steps**. Include links to files or GitHub projects, or copy/pasteable snippets, which you use in those examples. If you're providing snippets in the issue, use [Markdown code blocks](https://help.github.com/articles/markdown-basics/#multiple-lines).
-   **Describe the behavior you observed after following the steps** and point out what exactly is the problem with that behavior.
-   **Explain which behavior you expected to see instead and why.**

Provide more context by answering these questions:

-   **Did the problem start happening recently** (e.g. after updating to a new version of Manage) or was this always a problem?
-   **Can you reliably reproduce the issue?** If not, provide details about how often the problem happens and under which conditions it normally happens.

Include details about your configuration and environment:

-   **Include the debug output from [New-CWMDebugReport](<>)!**
-   **What's the name and version of the OS you're using**?

### Suggesting Enhancements

This section guides you through submitting an enhancement suggestion, including completely new features and minor improvements to existing functionality. Following these guidelines helps maintainers and the community understand your suggestion :pencil: and find related suggestions :mag_right:.

Before creating enhancement suggestions, please check existing suggestions as you might find out that you don't need to create one. When you are creating an enhancement suggestion, please include as many details as possible. Fill in the template, including the steps that you imagine you would take if the feature you're requesting existed.

#### Before Submitting An Enhancement Suggestion

-   **Check the [Wiki](<>)** for tips — you might discover that the enhancement is already available.
-   **Check if there's already [a package](<>) which provides that enhancement.**

#### How Do I Submit A (Good) Enhancement Suggestion

Enhancement suggestions are tracked as [GitHub issues](https://guides.github.com/features/issues/).Create an issue and provide the following information:

-   **Use a clear and descriptive title** for the issue to identify the suggestion.
-   **Provide a step-by-step description of the suggested enhancement** in as many details as possible.
-   **Provide specific examples to demonstrate the steps**. Include copy/pasteable snippets which you use in those examples, as [Markdown code blocks](https://help.github.com/articles/markdown-basics/#multiple-lines).
-   **Describe the current behavior** and **explain which behavior you expected to see instead** and why.
-   **Explain why this enhancement would be useful** to most users and isn't something that can or should be implemented as a [community package](<>).
-   **List some other text examples where this enhancement exists.**
-   **Specify which version of manage you're using.**
-   **Specify the name and version of the OS you're using.**

## Styleguides

### Git Commit Messages

-   Use the present tense ("Add feature" not "Added feature")

-   Use the imperative mood ("Move cursor to..." not "Moves cursor to...")

-   Limit the first line to 72 characters or less

-   Reference issues and pull requests liberally after the first line

-   When only changing documentation, include `[ci skip]` in the commit title

-   Consider starting the commit message with an applicable emoji:
    -   :art: `:art:` when improving the format/structure of the code
    -   :racehorse: `:racehorse:` when improving performance
    -   :non-potable_water: `:non-potable_water:` when plugging memory leaks
    -   :memo: `:memo:` when writing docs
    -   :penguin: `:penguin:` when fixing something on Linux
    -   :apple: `:apple:` when fixing something on macOS
    -   :checkered_flag: `:checkered_flag:` when fixing something on Windows
    -   :bug: `:bug:` when fixing a bug
    -   :fire: `:fire:` when removing code or files
    -   :green_heart: `:green_heart:` when fixing the CI build
    -   :white_check_mark: `:white_check_mark:` when adding tests
    -   :lock: `:lock:` when dealing with security
    -   :arrow_up: `:arrow_up:` when upgrading dependencies
    -   :arrow_down: `:arrow_down:` when downgrading dependencies
    -   :shirt: `:shirt:` when removing linter warnings

### PowerShell Styleguide

-   Refer to the [unofficial guide](https://github.com/PoshCode/PowerShellPracticeAndStyle).

### Documentation Styleguide

-   Use [Markdown](https://daringfireball.net/projects/markdown).
-   Documentation is built with platyPS from the markdown.
