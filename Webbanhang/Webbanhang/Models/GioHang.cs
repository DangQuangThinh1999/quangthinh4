using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Webbanhang.Models;

namespace Webbanhang.Models
{
        public class GioHang
        {
            QLSPDataContext data = new QLSPDataContext();
            public int iMasp { set; get; }
            public string sTensp { set; get; }
            public string sAnhbia { set; get; }
            public Double dDongia { set; get; }
            public int iSoluong { set; get; }
            public Double dThanhtien
            {
                get { return iSoluong * dDongia; }
            }

            public GioHang(int Masp)
            {
                iMasp = Masp;
                SANPHAM sp = data.SANPHAMs.Single(n => n.MASP == iMasp);
                sTensp = sp.TENSP;
                sAnhbia = sp.ANHBIA;
                dDongia = double.Parse(sp.GIABAN.ToString());
                iSoluong = 1;
            }
        }
    }