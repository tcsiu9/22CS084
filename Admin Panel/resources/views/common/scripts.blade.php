<script src="{{ secure_asset('https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js') }}" crossorigin="anonymous"></script>
<script src="{{ secure_asset('https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.13.2/jquery-ui.min.js') }}" crossorigin="anonymous"></script>
<script src="{{ secure_asset('https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.2.3/js/bootstrap.bundle.min.js') }}" crossorigin="anonymous"></script>
<script src="{{ secure_asset('https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.11.7/umd/popper.min.js') }}" crossorigin="anonymous"></script>
<script src="{{ secure_asset('https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.2.3/js/bootstrap.min.js') }}" crossorigin="anonymous"></script>
<script src="{{ secure_asset('https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js') }}" crossorigin="anonymous"></script>
<script src="{{ secure_asset('https://cdnjs.cloudflare.com/ajax/libs/feather-icons/4.29.0/feather.min.js') }}" crossorigin="anonymous"></script>
<script src="{{ secure_asset('https://cdnjs.cloudflare.com/ajax/libs/dropzone/5.9.3/dropzone.min.js') }}" crossorigin="anonymous"></script>
<script src="{{ secure_asset('js/app.js') }}"></script>
<script src="{{ secure_asset('js/custom.js') }}"></script>
@push('scripts')
<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function(e){
	feather.replace();
	$('.datepicker').datepicker({format : 'yyyy-mm-dd', startDate: '0d',});
});
</script>
@endpush
@stack("scripts")