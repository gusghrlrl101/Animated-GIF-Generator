<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>GIF 이미지 업로드/다운로드</title>

    <%@include file="assets/IncAsset.jsp" %>
    <style>
        div.row > div > a:hover {
            text-decoration: none;
        }
    </style>
</head>

<body>
<div id="wrapper">
    <%@include file="assets/IncHeader.jsp" %>

    <div id="page-wrapper" style="margin: 0 0 0 20px;padding: 0 10px;">
        <%--<div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">웹플리케이션</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>--%>
        <!-- /.row -->
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-information">GIF 파일 변환
                </h1>
            </div>
            <div class="clear"></div>
            <!-- /.col-lg-12 -->
        </div>
        <!-- /.row -->
        <div class="row clear">
            &nbsp;
        </div>
        <!-- /.row -->
        <div class="row">
            <div class="col-lg-8 col-md-12">
                <div class="panel panel-default" style="background-color: #FAFAFA; height: 860px;">
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-md-12">
                                <h2>이미지 리스트</h2>
                            </div>
                        </div>
                        <br>
                        <div class="row">
                            <div class="col-xs-5">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <span>업로드된 이미지</span>
                                    </div>
                                    <div class="panel-body">
                                        <div class="form-group">
                                            <select class="form-control" style="height: 130px;" id="imgList" multiple>

                                            </select>
                                        </div>
                                        <%--<button type="submit" class="btn btn-default">Submit Button</button>--%>
                                        <button id="btnRefresh" class="btn btn-default">새로고침</button>
                                    </div>

                                </div>
                            </div>
                            <div class="col-xs-1">
                                <br><br>
                                <button class="btn btn-default text-center" style="width: 100%;" id="btnImgRight"><i class="fa fa-arrow-right"></i></button>
                                <br><br>
                                <button class="btn btn-default text-center" style="width: 100%;" id="btnImgLeft"><i class="fa fa-arrow-left"></i></button>
                                <br><br>
                                <button class="btn btn-default text-center" style="width: 100%;" id="btnImgDelete"><i class="fa fa-times"></i></button>
                            </div>
                            <div class="col-xs-5">
                                <div class="panel panel-primary">
                                    <div class="panel-heading">
                                        <span>GIF 생성할 이미지</span>
                                    </div>
                                    <div class="panel-body">
                                        <div class="form-group">
                                            <select class="form-control" style="height: 160px;" id="gifList" multiple>
                                             <%--   <option>1.jpg</option>
                                                <option>2.jpg</option>
                                                <option>3.jpg</option>--%>
                                            </select>
                                        </div>
                                        <%--<button type="submit" class="btn btn-default">Submit Button</button>--%>
                                        <%--<button type="reset" class="btn btn-default">새로고침</button>--%>
                                    </div>

                                </div>
                            </div>
                            <div class="col-xs-1">
                                <br><br><br><br>
                                <button class="btn btn-default text-center" style="width: 100%;" id="btnGifUp"><i class="fa fa-arrow-up"></i></button>
                                <br><br>
                                <button class="btn btn-default text-center" style="width: 100%;" id="btnGifDown"><i class="fa fa-arrow-down"></i></button>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-6">
                                <div class="panel panel-default">
                                    <div class="panel-body" style="height: 340px;">
                                        <p class="text-info" style="font-size:25px;">이미지 파일 업로드</p>
                                        <div class="form-group">
                                            <form action="/uploadFile" method="POST" enctype="multipart/form-data" id="uploadForm">
                                                <input type="file" name="file" accept="image/*" multiple="multiple"/>
                                            </form>
                                        </div>
                                        <button type="submit" class="btn btn-primary" id="btnUploadImg">업로드</button>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xs-6">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <p class="text-center" style="font-size:20px;">미리보기</p>
                                    </div>
                                    <div class="panel-body text-center" id="preview" style="background-color: white; height: 245px;">
                                        <br><br><br><br>
                                        <i class="fa fa-image fa-5x"></i>
                                    </div>
                                    <div class="panel-footer">
                                        <p class="text-center" style="font-size:20px;"></p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <button class="btn btn-primary" style="width: 100%; font-size: 16px;" id="btnMakeGif"><strong>GIF 만들기!</strong></button>
                            </div>
                        </div>
                        <br>
                        <div class="row">
                            <div class="col-xs-12">
                                <a class="btn btn-success" style="width: 100%; font-size: 16px;" id="btnDownloadGif" href="#"><strong>GIF 다운로드</strong></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 col-md-12">
                <div class="panel panel-default" style="background-color: #FAFAFA">
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-md-12">
                                <h2>설정</h2>
                            </div>
                        </div>
                        <br>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="panel panel-default">
                                    <div class="panel-body">
                                        <h4>공통</h4>
                                        <div class="row">
                                            <div class="col-xs-6">
                                                <div class="form-group">
                                                    <label>반복 횟수</label>
                                                    <input class="form-control" id="loopCount" />
                                                    <p class="help-block">빈 칸시 무한 루프</p>
                                                </div>
                                            </div>
                                            <div class="col-xs-6">
                                                <div class="form-group">
                                                    <label>프레임당 지연 시간</label>
                                                    <input class="form-control" id="fileDurationAll" value="1000" />
                                                    <p class="help-block">이 값을 변경하면 모든 프레임의 지연시간이 변경됩니다.</p>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-6">
                                                <div class="form-group">
                                                    <label>GIF 너비</label>
                                                    <input class="form-control" id="fileWidth" />
                                                    <p class="help-block">빈 칸시 이미지 기본 값</p>
                                                </div>
                                            </div>
                                            <div class="col-xs-6">
                                                <div class="form-group">
                                                    <label>GIF 높이</label>
                                                    <input class="form-control" id="fileHeight"  />
                                                    <p class="help-block">빈 칸시 이미지 기본 값</p>
                                                </div>
                                            </div>
                                            <%--
                                            <div class="col-xs-12">
                                                <div class="form-group">
                                                    <div class="checkbox">
                                                        <label>
                                                            <input type="checkbox" value="">프레임 간 페이드 효과 추가
                                                        </label>
                                                    </div>
                                                    <div class="panel panel-default">
                                                        <div class="panel-body">
                                                            <div class="row">
                                                                <div class="col-xs-6">
                                                                    <div class="form-group">
                                                                        <label>페이더 지연시간</label>
                                                                        <input class="form-control" />
                                                                        <p class="help-block">프레임간 페이드 효과 시 걸리는 지연시간입니다.</p>
                                                                    </div>
                                                                </div>
                                                                <div class="col-xs-6">
                                                                    <div class="form-group">
                                                                        <label>프레임 개수</label>
                                                                        <input class="form-control" />
                                                                        <p class="help-block">페이드 효과에 추가되는 프레임의 개수입니다.</p>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col-xs-12">
                                                                    <div class="form-group">
                                                                        <div class="checkbox">
                                                                            <label>
                                                                                <input type="checkbox" value="">처음 프레임과 마지막 프레임은 페이드 효과 없음
                                                                            </label>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            --%>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-6">
                                                <div class="form-group">
                                                    <div class="checkbox">
                                                        <label>
                                                            <input type="checkbox" value="" id="dithering">디더링 효과
                                                        </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-6">
                                                <div class="form-group">
                                                    <div class="checkbox">
                                                        <label>
                                                            <input type="checkbox" value="" id="optimizing">최적화
                                                        </label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="panel-body" id="filePropertyPanel" style="display:none;">
                                        <div id="fileProperty"><h4></h4></div>
                                        <div class="form-group">
                                            <label>지연 시간</label>
                                            <input class="form-control" id="fileDuration" />
                                            <p class="help-block">이 프레임의 지연시간입니다.</p>
                                        </div>
                                        <div class="form-group">
                                            <label>회전 각도</label>
                                            <select class="form-control" id="fileRotation">
                                                <option value="0" selected="selected">0 도</option>
                                                <option value="90">90 도</option>
                                                <option value="180">180 도</option>
                                                <option value="270">270 도</option>
                                            </select>
                                            <p class="help-block">프레임의 회전 각도(반시계) 입니다.</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- /#page-wrapper -->

</div>
<!-- /#wrapper -->


<%@include file="assets/IncFooter.jsp" %>
<script src="/resources/js/jquery.selectlistactions.js"></script>
<script>
    var URL = 'http://101.101.161.247';

    $(document).ready(function () {
        // GIF Parameters
        $('#fileDuration').focusout(function (e) {
            var fileName = $("#fileProperty h4").html();
            if(fileName === "")
                return false;

            var $list = $("#imgList option");
            for(var i = 0; i < $list.length; i++) {
                if($list[i].innerHTML === fileName) {
                    $list[i].value = $(this).val();
                    return true;
                }
            }

            $list = $("#gifList option");
            for(var i = 0; i < $list.length; i++) {
                if($list[i].innerHTML === fileName) {
                    $list[i].value = $(this).val();
                    return true;
                }
            }
        });

        $('#fileRotation').change(function (e) {
            var fileName = $("#fileProperty h4").html();
            if(fileName === "")
                return false;

            $("#previewImg").css("transform", "rotate(" + (360 - Number($("#fileRotation option:selected").val())) + "deg)");

            var $list = $("#imgList option");
            for(var i = 0; i < $list.length; i++) {
                if($list[i].innerHTML === fileName) {
                    $list[i].setAttribute("rotation", $("#fileRotation option:selected").val());
                    return true;
                }
            }

            $list = $("#gifList option");
            for(var i = 0; i < $list.length; i++) {
                if($list[i].innerHTML === fileName) {
                    $list[i].setAttribute("rotation", $("#fileRotation option:selected").val());
                    return true;
                }
            }
        });

        $('#fileDurationAll').focusout(function (e) {
            var $list = $("#imgList option");
            for(var i = 0; i < $list.length; i++) {
                $list[i].value = $(this).val();
            }

            $list = $("#gifList option");
            for(var i = 0; i < $list.length; i++) {
                $list[i].value = $(this).val();
            }
        });
        
        $('#btnImgLeft').click(function (e) {
            $('select').moveToListAndDelete('#gifList', '#imgList');
            e.preventDefault();
        });

        $('#btnImgRight').click(function (e) {
            $('select').moveToListAndDelete('#imgList', '#gifList');
            e.preventDefault();
        });

        $('#btnGifUp').click(function (e) {
            $('select').moveUpDown('#gifList', true, false);
            e.preventDefault();
        });

        $('#btnGifDown').click(function (e) {
            $('select').moveUpDown('#gifList', false, true);
            e.preventDefault();
        });

        $('#btnRefresh').click(function () {
            reloadImgList();
        });

        $('#btnImgDelete').click(function (e) {
            var $selectedList = $("#imgList option:selected");
            if(!confirm("선택된 " + $selectedList.length + "항목을 삭제하시겠습니까?"))
                return false;

            var fileList = new Array();
            for(var i = 0; i < $selectedList.length; i++) {
                var fileObj = new Object();
                fileObj.fileName = $selectedList[i].innerHTML;
                fileList.push(fileObj);
            }
            var requestObj = new Object();
            requestObj.fileList = fileList;
            var data = JSON.stringify(requestObj);

            var ajaxReq = $.ajax({
                url: '/imgList',
                type: 'DELETE',
                data: data,
                cache: false,
                processData: false,
                contentType: 'application/json'
            });

            // Called on success
            ajaxReq.done(function (msg) {
                $('select').removeSelected('#imgList');
            });

            // Called on failure
            ajaxReq.fail(function (jqXHR) {
                console.log(jqXHR);
            });
        });

        $('#imgList').click(function () {
            // Preview Change
            $("#preview").empty();
            $("#preview").append("<img src='" + URL + "/image/downloads/" + $("#imgList option:selected").html() + "' alt='"+
                $("#imgList option:selected").html() + "' height=200 id='previewImg' />");

            // Property Change
            $('#filePropertyPanel').show();
            $("#fileProperty h4").html($("#imgList option:selected").html());
            $("#fileDuration").val($("#imgList option:selected").val());
            $("#fileRotation").val($("#imgList option:selected").attr("rotation"));
            $("#previewImg").css("transform", "rotate(" + (360 - Number($("#fileRotation option:selected").val())) + "deg)");
        });

        $('#gifList').click(function () {
            // Preview Change
            $("#preview").empty();
            $("#preview").append("<img src='" + URL + "/image/downloads/" + $("#gifList option:selected").html() + "' alt='"+
                $("#gifList option:selected").html() + "' height=200 id='previewImg' />");

            // Property Change
            $('#filePropertyPanel').show();
            $("#fileProperty h4").html($("#gifList option:selected").html());
            $("#fileDuration").val($("#gifList option:selected").val())
            $("#fileRotation").val($("#gifList option:selected").attr("rotation"));
            $("#previewImg").css("transform", "rotate(" + (360 - Number($("#fileRotation option:selected").val())) + "deg)");
        });

        $('#btnUploadImg').click(function (e) {
            e.preventDefault();

            if( $('input[type=file]').val() === '') {
                alert("업로드 할 게 없어요");
                return false;
            }

            //Disable submit button
            $(this).prop('disabled', true);
            $(this).html("업로드 중입니다...");

            var formData = new FormData($("#uploadForm")[0]);

            // Ajax call for file uploading
            var ajaxReq = $.ajax({
                 url: '/uploadFile',
                type: 'POST',
                data: formData,
                cache: false,
                contentType: false,
                processData: false
            });

            // Called on success
            ajaxReq.done(function (msg) {
                $('input[type=file]').val('');
                $('#btnUploadImg').prop('disabled', false);
                $('#btnUploadImg').html("업로드");
                reloadImgList();
            });

            // Called on failure
            ajaxReq.fail(function (jqXHR) {
                console.log(jqXHR);
                $('#btnUploadImg').prop('disabled', false);
                $('#btnUploadImg').html("업로드");
                reloadImgList();
            });
        });

        $('#btnMakeGif').click(function () {
            var $selectedList = $("#gifList option");
            if($selectedList.length === 0) {
                alert("GIF 변환 할 게 없어요");
                return false;
            }

            $(this).prop('disabled', true);
            $(this).html("GIF 변환 중입니다...");
            $('#btnDownloadGif').hide();

            var fileList = new Array();
            for(var i = 0; i < $selectedList.length; i++) {
                var fileObj = new Object();
                fileObj.fileName = $selectedList[i].innerHTML;
                fileObj.duration = $selectedList[i].value;
                fileObj.rotation = $selectedList[i].getAttribute("rotation");
                fileList.push(fileObj);
            }
            var requestObj = new Object();
            requestObj.fileList = fileList;
            requestObj.requestId = String(new Date().getTime());
            if($("#loopCount").val() !== "")
                requestObj.loopCount = Number($("#loopCount").val());
            if($("#fileWidth").val() !== "")
                requestObj.width = Number($("#fileWidth").val());
            if($("#fileHeight").val() !== "")
                requestObj.height = Number($("#fileHeight").val());
            requestObj.dithering = $("#dithering").is(":checked");
            requestObj.optimizing = $("#optimizing").is(":checked");

            var data = JSON.stringify(requestObj);

            var ajaxReq = $.ajax({
                url: URL + '/api/makeGif',
                type: 'POST',
                data: data,
                cache: false,
                processData: false,
                contentType: 'application/json'
            });

            // Called on success
            ajaxReq.done(function (msg) {
                //var data = JSON.parse(msg);
                var data = msg;
                if(data.result !== "OK"){
                    console.log(msg);
                    return;
                }

                $('#btnDownloadGif').prop("href", URL + data.filePath);
                $('#btnDownloadGif').show();

                $("#btnMakeGif").prop('disabled', false);
                $("#btnMakeGif").html("GIF 만들기!");
            });

            // Called on failure
            ajaxReq.fail(function (jqXHR) {
                console.log(jqXHR);
                $("#btnMakeGif").prop('disabled', false);
                $("#btnMakeGif").html("GIF 만들기!");
            });
        });

        reloadImgList();
        $('#btnDownloadGif').hide();
    });

    function reloadImgList() {
        var ajaxReq = $.ajax({
            url: '/imgList',
            type: 'GET',
            cache: false,
            contentType: false,
            processData: false
        });

        // Called on success
        ajaxReq.done(function (msg) {
            $("#imgList").empty();
            $("#gifList").empty();

            var data = JSON.parse(msg);
            if(data['listCount'] === 0)
                return;

            var imgList = data['imgList'];
            for(var i = 0; i < imgList.length; i++)
                $("#imgList").append("<option value='1000' rotation='0'>" + imgList[i]['fileName'] + "</option>");
        });

        // Called on failure
        ajaxReq.fail(function (jqXHR) {
            console.log(jqXHR);
        });
    }
</script>
</body>

</html>
