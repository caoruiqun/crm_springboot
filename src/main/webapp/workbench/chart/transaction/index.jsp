<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>

<html>
<head>
    <base href="<%=basePath%>">
    <title>Title</title>
    <script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
    <script src="ECharts/echarts.min.js"></script>
    <script>

        $(function () {

            getCharts();

        })

        function getCharts() {

            $.ajax({

                url : "workbench/transaction/getCharts.do",
                type : "get",
                dataType : "json",
                success : function (data) {

                    /*

                        data
                            {"total":100,"dataList":[{value: ?, name: '?'},{value: ?, name: '?'},{value: ?, name: '?'},]}

                            value:统计的数量
                            name:统计项

                            例如：我们现在统计的是不同交易阶段的数量的统计

                            echarts要求的数据的格式：
                            [
                                {"value":10,"name":"01资质审查"},
                                {"value":3,"name":"02需求分析"},
                                {"value":110,"name":"03价值建议"},
                                {"value":20,"name":"04..."},
                                {"value":210,"name":"05..."},
                                {"value":200,"name":"06..."},
                                {"value":10,"name":"07成交"},
                                {"value":50,"name":"08丢失的线索"},
                                {"value":75,"name":"09因竞争丢失"}
                             ]
                                05
                                ..
                                ..
                                ..
                                02



                     */



                    //然后就可以通过 echarts.init 方法初始化一个 echarts 实例
                    // 基于准备好的dom，初始化echarts实例
                    var myChart = echarts.init(document.getElementById('main'));



                    // 指定图表的配置项和数据
                    var option = {
                        title: {
                            text: '交易漏斗图',
                            subtext: '统计不同交易阶段数量的漏斗图'
                        },

                        series: [
                            {
                                name:'交易漏斗图',
                                type:'funnel',
                                left: '10%',
                                top: 60,
                                //x2: 80,
                                bottom: 60,
                                width: '80%',
                                // height: {totalHeight} - y - y2,
                                min: 0,
                                max: data.total,
                                minSize: '0%',
                                maxSize: '100%',
                                sort: 'descending',
                                gap: 2,
                                label: {
                                    show: true,
                                    position: 'inside'
                                },
                                labelLine: {
                                    length: 10,
                                    lineStyle: {
                                        width: 1,
                                        type: 'solid'
                                    }
                                },
                                itemStyle: {
                                    borderColor: '#fff',
                                    borderWidth: 1
                                },
                                emphasis: {
                                    label: {
                                        fontSize: 20
                                    }
                                },
                                data: data.dataList
                                    /*[
                                    {value: 60, name: '访问'},
                                    {value: 40, name: '咨询'},
                                    {value: 20, name: '订单'},
                                    {value: 80, name: '点击'},
                                    {value: 100, name: '展现'}
                                ]*/
                            }
                        ]
                    };



                    //通过 setOption 方法生成一个简单的柱状图
                    myChart.setOption(option);








                }

            })



        }
        
    </script>
</head>
<body>

    <!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
    <div id="main" style="width: 600px;height:400px;"></div>

</body>
</html>
