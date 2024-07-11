<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
</head>
<body>

    hjhhjhk
    <br>
    {{ basename( url()->current() )}}

    @if ( basename( url()->current() ) == 'builds'  && $builds != null)
        @foreach ($builds as $build)
            <p>{{ $build->name."   :   ".$build->city ."   :   ".$build->address }}</p>
            <br>
            {{ $renter = $build->renters()->first(); }}
            @if($renter != null)
                <p>{{ $renter->name."   :   ".$renter->rent."   :   ".$renter->job_bomain }}
            @endif
        @endforeach
    @endif

    @if ( basename( url()->current() ) == 'renters' && $builds != null)
    @foreach ($builds as $build)
        </p>
        <br>
    @endforeach
    @endif
    
    @if ( $builds->isNotEmpty() )
        <a href="{{url('renters/'.$builds[0]->id) }} "> Renters </a>
        <a href="{{url('builds/'.$builds[0]->id).'/delete' }} "> del </a>
    @endif
    
</body>
</html>