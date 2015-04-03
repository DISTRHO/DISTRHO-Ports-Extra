/* Copyright 2012 Kjetil S. Matheussen

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA. */

#ifndef QT_SLIDERPAINTERPAINTER_H
#define QT_SLIDERPAINTERPAINTER_H

namespace cvs{


static inline void SLIDERPAINTERPAINTER_paint(MyPainter *p, int x1, int y1, int x2, int y2, bool is_enabled, float val, std::string text, bool alternative_color){
    static MyColor gray(200,200,200);
    int height = y2-y1;
    int width = x2-x1;

    MyColor col1;
    MyColor col1b;

    int col1num = 11;

    if(is_enabled){
      MyColor c(98,59,33);
      
      col1 = c.lighter(90);
      col1b = MyColor(13).lighter(100);
    }else{
      col1 =  mix_mycolors(MyColor(col1num),              gray, 0.8f);
      col1b = mix_mycolors(MyColor(col1num).lighter(110), gray, 0.8f);
    }
    
    if(alternative_color==true)
      col1 = MyColor(200,200,200);
    
    if(alternative_color==false){
      col1.setAlpha(80);
      col1b.setAlpha(100);
    }else{
      col1.setAlpha(120);
      col1b.setAlpha(120);
    }

    if(height > width){ // i.e. vertical
      int pos=scale(val,0,1,0,height);
      p->fillRect(0,pos,width,height,col1);
    }else{
      int pos=scale(val,0,1,0,width);

      p->setGradient(0,0,width,height*3/4,
                     alternative_color==false ? col1.lighter(100) : col1.lighter(150),
                     col1b);

      p->fillRect(0,0,pos,height,col1);
      p->unsetGradient();

      p->drawRect(0,0,pos,height,gray.lighter(50));

    }

    p->drawRect(0,0,width,height,MyColor(11).lighter(110));

    //QRect rect(5,2,width-5,height-2);
    MyRect rect(5,2,width,height);

    if(text.compare("")!=0){
      MyColor c(1);
      p->drawText(rect, text, c);
    }

}

} // namespace cvs


#endif // QT_SLIDERPAINTERPAINTER_H
