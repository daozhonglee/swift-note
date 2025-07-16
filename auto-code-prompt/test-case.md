## 单测

- 单测文件位置：在该文件 F 所在目录往父级追溯，找到第一个遇到的 internal 目录或者符合 ids_xxx 的目录 I， 其父目录为 P，记路径名为 P/internal/path/F 或 P/path/F。如果 P 目录有 test 目录，P 下的测试目录 test 记为 T，则在相同的相对路径下 /T/path/ 创建一个测试文件，如果存在同名同路径文件，在该文件里则追加一个单测。
- 单测文件命名：该类或方法所在文件名为 xxx，则单测文件命名为 xxx_test.go
- 单测要求：
 - 仔细阅读源代码实现，严格基于源代码实现来编写单测，不要测试不存在的逻辑。
 - 必须使用断言，不可以用 t.Errorf 和 fmt.Println。
 - 覆盖正常情况。
 - 覆盖空情况。
 - 覆盖临界情况。
 - 覆盖异常情况。
 - 单测需要具有可扩展性，能够轻松添加新的测试用例。
 - 严格按照代码里的枚举值作为单测用例的值，不要随意发挥。
 - 不能修改已有函数实现，除非函数有 BUG， 且要经过我的确认才能改。
 - 写一个单测方法运行一个，单测通过了，再写下一个。避免一下子写一大堆错误的单测。
 - 写完一个单测文件之后的所有单测之后，全部运行一遍，失败则修复。全部运行通过后再写下一个单测文件。
 - 编写表驱动风格的单元测试                                                                                  

# 示例

- internal/common/util/ip.go 单测文件位置 test/common/util/ip_test.go
- internal/ids_detect/internal/detections/utils/detect_result_utils.go 的单测位置 detections/utils/detect_result_utils_test.go

# 提示词
遵循 .cursor/rules/ut.mdc 的要求【事实上不需要这个】，生成 IsNetBlockIpAll 的单测
遵照 .cursor/rules/ut.mdc 给 SortByField 生成单测                                          