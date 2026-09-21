$(document).ready(function(){
    document.getElementById("userinfo").innerHTML =
        "<i class='fas fa-user'></i> " + username +
        " | <i class='fas fa-id-badge'></i> " + insCode +
        " | <i class='fas fa-building'></i> " + insName;
    loadReport();
});

function esc(v){
    if (v === null || v === undefined) return '';
    return $('<div/>').text(String(v)).html();
}

function photoSrc(b64){
    if(!b64) return '';
    if(/^data:/.test(b64)) return b64;
    return 'data:image/jpeg;base64,' + b64;
}

// GET ${backendBaseUrl}/itilogin/labs-report?itiCode=...
function loadReport(){
    $.ajax({
        type:'get',
        url: baseUrl + 'itilogin/labs-report?itiCode=' + encodeURIComponent(insCode),
        cache:false, timeout:600000,
        success: function(response){
            renderReport(response || []);
        },
        error: function(xhr){
            $("#reporttable").hide();
            $("#emptydatamsg").html('Error loading report.').show();
        }
    });
    return false;
}

function renderReport(rows){
    var thead = $("#reportthead"); thead.html('');
    var tbody = $("#reportbody"); tbody.html('');
    thead.append('<tr><th>SNO</th><th>INDUSTRY</th><th>TRADE</th>'
        + '<th>DESCRIPTION</th><th>ITEM NAME</th><th>ITEM COST</th><th>ITEM PHOTO</th></tr>');
    if(!rows.length){
        $("#reporttable").hide();
        $("#emptydatamsg").show();
        return;
    }
    $("#emptydatamsg").hide();
    $("#reporttable").show();
    rows.forEach(function(r, i){
        var img = r.itemPhoto
            ? '<img class="item-photo" src="' + photoSrc(r.itemPhoto) + '"/>'
            : '-';
        tbody.append('<tr>'
            + '<td>' + (i + 1) + '</td>'
            + '<td>' + esc(r.industryName) + '</td>'
            + '<td>' + esc(r.tradeShort) + '</td>'
            + '<td>' + esc(r.description) + '</td>'
            + '<td>' + esc(r.itemName) + '</td>'
            + '<td>' + esc(r.itemCost) + '</td>'
            + '<td>' + img + '</td>'
            + '</tr>');
    });
}

function downloadExcel(withPhoto){
    var table = document.getElementById('reporttable');
    if(!table || $("#reportbody tr").length === 0) return false;
    if(!withPhoto){
        var clone = table.cloneNode(true);
        Array.prototype.forEach.call(clone.rows, function(row){ row.deleteCell(-1); });
        var wb = XLSX.utils.table_to_book(clone, {sheet:"Sheet1"});
        XLSX.writeFile(wb, 'LABS_REPORT.xlsx');
    } else {
        var wb2 = XLSX.utils.table_to_book(table, {sheet:"Sheet1"});
        XLSX.writeFile(wb2, 'LABS_REPORT_WITH_PHOTO.xlsx');
    }
    return false;
}
