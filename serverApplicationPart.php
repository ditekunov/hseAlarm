<?php
	if ($_POST['Para'])
	{
		
		
		$data = $_POST['Date'];
		$para = $_POST['Para'];
		//$data = '2017-05-01';
		//$para = 2;
		
		$pars[1]=9*60;
		$pars[2]=10*60+30;
		$pars[3]=12*60+10;
		$pars[4]=13*60+40;
		$pars[5]=15*60+10;
		$pars[6]=16*60+40;
		$pars[7]=18*60+10;
		$pars[8]=19*60+40;
		
		$rettime = $pars[$para]-30;		// 30 - commutation in underground

		
		ini_set("allow_url_fopen", 1);
		$json = file_get_contents('https://api.rasp.yandex.net/v1.0/search/?apikey=858b9ea8-cfd2-4729-99e1-66c2bc9bf573&format=json&from=s9600721&to=s9601728&lang=ru&page=1&date='.$data);
		//echo $json;
		$obj = json_decode($json);
		
		$NumberOfTrains = $obj->pagination->total;
		$OurTrain =-1;
		$i = -1;
		while (($i-$OurTrain)==0)
		{
			$OurTrainArrival = 0;
			$i++;
			
			$OurTrainArrival += intval($obj->threads[$i]->arrival[strlen($obj->threads[$i]->arrival)-4]);
			$OurTrainArrival += intval($obj->threads[$i]->arrival[strlen($obj->threads[$i]->arrival)-5])*10;
			$OurTrainArrival += intval($obj->threads[$i]->arrival[strlen($obj->threads[$i]->arrival)-7])*60;
			$OurTrainArrival += intval($obj->threads[$i]->arrival[strlen($obj->threads[$i]->arrival)-8])*600;

			$comm = $OurTrainArrival+$obj->threads[$i]->duration/60;
			if ($comm<$rettime)
			{
				$OurTrain = $i;
				$ARRIVAL = $OurTrainArrival;
			}	
		}	

			
		$rettime = $ARRIVAL-50; // 50 - commutation to station
		echo (floor($rettime/60)).":".($rettime%60)."\n";
	}
?>
