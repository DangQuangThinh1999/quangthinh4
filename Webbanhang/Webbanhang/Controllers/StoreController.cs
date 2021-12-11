using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Webbanhang.Models;

using PagedList;
using PagedList.Mvc;
namespace Webbanhang.Controllers
{
    public class StoreController : Controller
    {
        //Tao 1 doi tuong chưa CSDL
        QLSPDataContext data = new QLSPDataContext();

        private List<SANPHAM> Layspmoi(int count)
        {
            return data.SANPHAMs.OrderByDescending(a => a.NGAYCAPNHAT).Take(count).ToList();
        }
        public ActionResult Index(int ? page)
        {
            //Tao biến quy định số sản phẩm trên mỗi trang
            int pageSize = 6;
            //Tạo biến số trang
            int pageNum = (page ?? 1);

            // Lấy top 5 sp bán chạy
            var spmoi = Layspmoi(30);
            return View(spmoi.ToPagedList(pageNum,pageSize));
        }
        public ActionResult Loai()
        {
            var loai = from l in data.LOAIs select l;
            return PartialView(loai);
        }
        public ActionResult Nhasanxuat()
        {
            var nhasx = from nsx in data.NHASANXUATs select nsx;
            return PartialView(nhasx);
        }
        public ActionResult SPTheoloai(int id)
        {
            var sp = from s in data.SANPHAMs where s.MAL == id select s;
            return View(sp);
        }
        public ActionResult SPTheonsx(int id)
        {
            var sp = from s in data.SANPHAMs where s.MANSX == id select s;
            return View(sp);
        }
        public ActionResult Details(int id)
        {
            var sp = from s in data.SANPHAMs
                       where s.MASP == id
                       select s;
            return View(sp.Single());
        }

    }
}