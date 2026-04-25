---
name: 题目转成sql插入代码
description: 题目转成sql插入代码
model: default
tools: list_files, search_file, search_content, read_file, read_lints, replace_in_file, write_to_file, execute_command, create_rule, delete_files, web_fetch, use_skill, web_search
agentMode: agentic
enabled: true
enabledAutoRun: true
---
我想你根据“QuestionsNew/Python questions transform prompts.txt"里的指令，将"QuestionsNew/python1/stage1"中的题目文本文件转换成MySQL插入代码（每个单元一个文件），然后放在"QuestionsNew/python1_insert/stage1"中。请你严格遵守prompt中的指令和prompt中的示例。