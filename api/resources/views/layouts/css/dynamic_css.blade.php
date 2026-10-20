<style type="text/css">
    #id_card::after {
        content: "";
        width: 100%;
        height: 100%;
        position: absolute;
        opacity: 0.2;
        top: 0;
        background-image: url('{{ get_logo() }}') !important;
        background-repeat: no-repeat !important;
        background-size: 100px auto !important;
        background-position: center !important;
    }

    .sidebar .sidebar-wrapper {
        background: {{ get_option('sidebar_color') != '' ? get_option('sidebar_color') : '#043268' }};
    }

    .sidebar .nav li:not(.active)>a,
    .sidebar[data-background-color="white"] .nav li:not(.active)>a {
        color: {{ get_option('sidebar_text_color') != '' ? get_option('sidebar_text_color') : '#FFFFFF' }};
    }

    .sidebar .logo .simple-text,
    .sidebar[data-background-color="white"] .logo .simple-text {
        color: {{ get_option('sidebar_text_color') != '' ? get_option('sidebar_text_color') : '#FFFFFF' }};
    }

    .metismenu li {
        border-bottom: 1px solid {{ get_option('sidebar_border_color') != '' ? get_option('sidebar_border_color') : 'rgba(255,255,255,0.15)' }};
    }

    @php $acb =get_option('active_sidebar_background')
    @endphp

    .sidebar[data-active-color="danger"] .nav li.active>a {
        background: {{ $acb != '' ? $acb : '#016DF6' }};
    }

    .nav li.active>ul>li.active>a {
        color: {{ $acb != '' ? $acb : '#016DF6' }} !important;
    }

    {!! get_option('custom_backend_css') !!} .div_one {
        position: relative;
    }

    .div_one::after {
        content: '';
        position: absolute;
        width: 2px;
        height: 45px;
        background-color: #fff;
        top: 10px;
        right: 0px;
    }

    .institute_and_year_div {
        background-color: #000;
        color: #fff;
        display: flex;
    }

    .institute_and_year_child_div {
        margin: 0;
        padding: 10px 5px;
        margin: 0;
        padding: 10px 5px;
    }

    .institute_div_heading {
        font-size: 12px;
        font-weight: 400;
        text-transform: uppercase;
        margin: 0;
        padding: 5px;
        font-size: 12px;
        font-weight: 400;
        text-transform: uppercase;
        margin: 0;
        padding: 5px;
    }

    .institute_div_span {
        padding: 0 5px;
        color: #29B2CA;
    }

    .divPaddingMargin {
        margin: 10px 0;
        padding: 0;
    }

    .institute_logo_img {
        width: 180px;
        height: 160px;
        border-radius: 5px;
        margin: 15px 0;
    }

    .institute_second_div_one {
        background-color: #00B09B !important;
        color: #fff !important;
        text-align: center;
    }

    .institute_second_div_two {
        background-color: #F06048 !important;
        color: #fff !important;
        text-align: center;
    }

    .institute_second_div_three {
        background-color: #1E7FFD !important;
        color: #fff !important;
        text-align: center;
    }

    .institute_second_div_four {
        background-color: #044BA5 !important;
        color: #fff !important;
        text-align: center;
    }

    .institute_second_div_one i,
    .institute_second_div_two i,
    .institute_second_div_three i,
    .institute_second_div_four i {
        font-size: 24px;
    }

    .institute_third_div img {
        max-width: 100%;
        max-height: 140px;
        border-radius: 5px;
        margin-top: 15px;
    }

    .institute_third_div .heading {
        margin: 0;
        padding: 0;
        margin: 10px 0;
    }

    .institute_third_div ul {
        list-style: none;
        margin: 0;
        padding: 0;
    }

    .institute_third_div ul li {
        margin-top: 5px;
    }

    .institute_third_div .right_div {
        background-color: #fff;
        width: 160px;
        height: 140px;
        border-radius: 5px;
        margin-top: 15px;
    }

    .institute_third_div .heading_four {
        padding-top: 30px;
        margin: 0;
        color: #000
    }

    .institute_third_div .heading_five {
        color: black;
        padding: 0;
    }

    .aside-custom-sidebar {
        background-color: #f4f3ef !important;
        box-shadow: none;
        border: none;
        padding: 0px 10px 0px 10px !important;
        margin-bottom: 0px !important;
    }
</style>
