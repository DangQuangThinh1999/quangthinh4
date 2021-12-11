using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PagedList;
using PagedList.Mvc;
using Webbanhang.Models;
using System.IO;

namespace Webbanhang.Controllers
{
    public class AdminController : Controller
    {
        QLSPDataContext db = new QLSPDataContext();
        // GET: Admin
        public ActionResult Index()
        {
            return View();
        }
        [HttpGet]
        public ActionResult Login()
        {
            return View();
        }
        public ActionResult SanPham(int? page)
        {
            int pageNumber = (page ?? 1);
            int pageSize = 7;
            return View(db.SANPHAMs.ToList().OrderBy(n => n.MASP).ToPagedList(pageNumber, pageSize));
        }
        [HttpPost]
        public ActionResult Login(FormCollection collection)
        {
            var tendn = collection["username"];
            var matkhau = collection["password"];
            if (tendn != null)
            {
                ADMIN ad = db.ADMINs.SingleOrDefault(n => n.USERADMIN == tendn && n.PASSADMIN == matkhau);
                if (ad != null)
                {
                    Session["TAIKHOANADMIN"] = ad;
                    return RedirectToAction("Index", "Admin");
                }
                else
                    ViewBag.Thongbao = "Tên đăng nhập hoặc mật khẩu không đúng!";
            }
            return View();
        }
        [HttpGet]
        public ActionResult Themmoisp()
        {
            ViewBag.MAL = new SelectList(db.LOAIs.ToList().OrderBy(n => n.TenLoai), "MAL", "TENLOAI");
            ViewBag.MaNSX = new SelectList(db.NHASANXUATs.ToList().OrderBy(n => n.TenNSX), "MANSX", "TENNSX");
            return View();
        }
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Themmoisp(SANPHAM sp, HttpPostedFileBase fileupload)
        {
            ViewBag.MAL = new SelectList(db.LOAIs.ToList().OrderBy(n => n.TenLoai), "MAL", "TENLOAI");
            ViewBag.MaNSX = new SelectList(db.NHASANXUATs.ToList().OrderBy(n => n.TenNSX), "MANSX", "TENNSX");
            if (fileupload == null)
            {
                ViewBag.Thongbao = "Vui lòng chọn ảnh bìa";
                return View();
            }
            else
            {
                if (ModelState.IsValid)
                {
                    var filename = Path.GetFileName(fileupload.FileName);
                    var path = Path.Combine(Server.MapPath("~/Asset/images"), filename);
                    if (System.IO.File.Exists(path))
                    {
                        ViewBag.Thongbao = "Hình ảnh đã tồn tại";
                    }
                    else
                    {
                        fileupload.SaveAs(path);
                    }
                    sp.ANHBIA = filename;
                    db.SANPHAMs.InsertOnSubmit(sp);
                    db.SubmitChanges();
                }
            }
            return RedirectToAction("SANPHAM");
        }

        public ActionResult Suasp(int id)
        {
            SANPHAM sp = db.SANPHAMs.SingleOrDefault(n => n.MASP == id);

            if (sp == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            ViewBag.MAL = new SelectList(db.LOAIs.ToList().OrderBy(n => n.TenLoai), "MAL", "TENLOAI",sp.MAL);
            ViewBag.MaNSX = new SelectList(db.NHASANXUATs.ToList().OrderBy(n => n.TenNSX), "MANSX", "TENNSX", sp.MANSX);
            return View(sp);
        }
        public ActionResult Chitietsp(int id)
        {
            SANPHAM sp = db.SANPHAMs.SingleOrDefault(n => n.MASP == id);
            ViewBag.Masp = sp.MASP;
            if (sp == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            return View(sp);
        }
        [HttpGet]
        public ActionResult Xoasp(int id)
        {
            SANPHAM sp = db.SANPHAMs.SingleOrDefault(n => n.MASP == id);
            ViewBag.Masp = sp.MASP;
            if (sp == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            return View(sp);
        }
        [HttpPost, ActionName("Xoasp")]
        public ActionResult Xacnhanxoa(int id)
        {
            SANPHAM sp = db.SANPHAMs.SingleOrDefault(n => n.MASP == id);
            ViewBag.Masp = sp.MASP;
            if (sp == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            db.SANPHAMs.DeleteOnSubmit(sp);
            db.SubmitChanges();
            return RedirectToAction("SANPHAM");
        }
        public ActionResult Loai()
        {
            return View(db.LOAIs.ToList());
        }
        [HttpGet]
        public ActionResult Themmoiloai()
        {
            return View();
        }
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Themmoiloai(LOAI loai)
        {
            db.LOAIs.InsertOnSubmit(loai);
            db.SubmitChanges();
            return RedirectToAction("LOAI");
        }
        public ActionResult Xoaloai(int id)
        {
            LOAI loai = db.LOAIs.SingleOrDefault(n => n.MaL == id);
            ViewBag.Mal = loai.MaL;
            if (loai == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            return View(loai);
        }
        [HttpPost, ActionName("Xoaloai")]
        public ActionResult Xacnhanxoaloai(int id)
        {
            LOAI loai = db.LOAIs.SingleOrDefault(n => n.MaL == id);
            ViewBag.Mal = loai.MaL;
            if (loai == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            db.LOAIs.DeleteOnSubmit(loai);
            db.SubmitChanges();
            return RedirectToAction("LOAI");
        }
        [HttpGet]
        public ActionResult Sualoai(int id)
        {
            LOAI loai = db.LOAIs.SingleOrDefault(n => n.MaL == id);
            ViewBag.Mal = loai.MaL;
            if (loai == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            return View(loai);
        }
        public ActionResult Nhasanxuat()
        {
            return View(db.NHASANXUATs.ToList());
        }
        [HttpGet]
        public ActionResult Themmoinsx()
        {
            return View();
        }
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Themmoinsx(NHASANXUAT nsx)
        {
            db.NHASANXUATs.InsertOnSubmit(nsx);
            db.SubmitChanges();
            return RedirectToAction("NHASANXUAT");
        }
        public ActionResult Xoansx(int id)
        {
            NHASANXUAT nsx = db.NHASANXUATs.SingleOrDefault(n => n.MaNSX == id);
            ViewBag.MANSX = nsx.MaNSX;
            if (nsx == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            return View(nsx);
        }
        [HttpPost, ActionName("Xoansx")]
        public ActionResult Xacnhanxoansx(int id)
        {
            NHASANXUAT nsx = db.NHASANXUATs.SingleOrDefault(n => n.MaNSX == id);
            ViewBag.MANSX = nsx.MaNSX;
            if (nsx == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            db.NHASANXUATs.DeleteOnSubmit(nsx);
            db.SubmitChanges();
            return RedirectToAction("NHASANXUAT");
        }
        [HttpGet]
        public ActionResult Suansx(int id)
        {
            NHASANXUAT nsx = db.NHASANXUATs.SingleOrDefault(n => n.MaNSX == id);
            ViewBag.MANSX = nsx.MaNSX;
            if (nsx == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            return View(nsx);
        }
    }
}