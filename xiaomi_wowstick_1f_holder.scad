$segment_width=8.0;  // 7.5 seems ok, but testing a little bit more
$segment_height=16.0;//16.0 looks ok
$hole_width=4.55;    // 4.5 is the perfect value, but tolerance is needed
$hole_height=15.0;   //15.0 is the perfect value

$plan=[
  ["PH","PH",""  ,""  ,""  ,"PH","PH","PH","PH","PH","PH"],
  ["SL",""  ,""  ,""  ,"SL","SL","SL","SL","SL","SL","SL"],  
  ["H" ,""  ,""  ,"H" ,"H" ,"H" ,"H" ,"H" ,"H" ,"H" ,"H" ],
  ["T" ,"T" ,"T" ,"T" ,"T" ,"T" ,"T" ,"T" ,"T" ,"T" ,"T" ],
  ["TR","TR","TR","TR",""  ,""  ,"Y" ,"Y" ,"Y" ,"Y" ,"Y" ],
  ["S" ,"S" ,"S" ,""  ,""  ,""  ,""  ,""  ,"P" ,"P" ,"P" ],
  ["U" ,"U" ,"U" ,""  ,""  ,""  ,""  ,""  ,"W" ,""  ,"C" ],
];



module fhex(wid,height){
  hull(){
    cube([wid/1.7,wid,height],center = true);
    rotate([0,0,120])cube([wid/1.7,wid,height],center = true);
    rotate([0,0,240])cube([wid/1.7,wid,height],center = true);
  }
}

module segment(txt=""){
  difference(){
    cube([$segment_width,$segment_width,$segment_height]);

    translate([$segment_width/2,$segment_width/2,$segment_height-$hole_height/2])
    fhex($hole_width,$hole_height);
   
    extrusion=1;
    translate([0,extrusion,0])
    rotate([90,0,0])
    linear_extrude(extrusion){
      divider=3.0*len(txt);
      translate([$segment_width/divider,$segment_height-$segment_width/2,0]){
        text(txt, size=$segment_width/2, font="Ubuntu Mono:style=Bold");
      }
    }
  }

}

module segment_in_grid(x,y,txt=""){
  translate([x*$segment_width, y*$segment_width, y*$segment_height]){
    if (len(txt)>0) segment(txt);
    else cube([$segment_width,$segment_width,$segment_height]);
  }
  translate([x*$segment_width, y*$segment_width, 0]){
    cube([$segment_width, $segment_width, y*$segment_height]);
  }
}

yl=len($plan)-1;
for (y=[0:yl]){
  for (x=[0:len($plan[yl-y])-1]){
    segment_in_grid(x,y,txt=$plan[yl-y][x]);
  }
}
