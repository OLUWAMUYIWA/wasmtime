;;! target = "x86_64"
;;! flags = "-W function-references,gc -C collector=drc"
;;! test = "optimize"

(module
  (type $ty (struct (field (mut f32))
                    (field (mut i8))
                    (field (mut anyref))))

  (func (param (ref null $ty)) (result f32)
    (struct.get $ty 0 (local.get 0))
  )

  (func (param (ref null $ty)) (result i32)
    (struct.get_s $ty 1 (local.get 0))
  )

  (func (param (ref null $ty)) (result i32)
    (struct.get_u $ty 1 (local.get 0))
  )

  (func (param (ref null $ty)) (result anyref)
    (struct.get $ty 2 (local.get 0))
  )
)
;; function u0:0(i64 vmctx, i64, i32) -> f32 tail {
;;     gv0 = vmctx
;;     gv1 = load.i64 notrap aligned readonly gv0+8
;;     gv2 = load.i64 notrap aligned gv1+16
;;     gv3 = vmctx
;;     gv4 = load.i64 notrap aligned readonly can_move gv3+8
;;     gv5 = load.i64 notrap aligned readonly can_move gv4+24
;;     gv6 = load.i64 notrap aligned gv4+32
;;     stack_limit = gv2
;;
;;                                 block0(v0: i64, v1: i64, v2: i32):
;; @0033                               trapz v2, user16
;; @0033                               v10 = load.i64 notrap aligned readonly can_move v0+8
;; @0033                               v5 = load.i64 notrap aligned readonly can_move v10+24
;; @0033                               v4 = uextend.i64 v2
;; @0033                               v6 = iadd v5, v4
;; @0033                               v7 = iconst.i64 24
;; @0033                               v8 = iadd v6, v7  ; v7 = 24
;; @0033                               v9 = load.f32 notrap aligned little v8
;; @0037                               jump block1
;;
;;                                 block1:
;; @0037                               return v9
;; }
;;
;; function u0:1(i64 vmctx, i64, i32) -> i32 tail {
;;     gv0 = vmctx
;;     gv1 = load.i64 notrap aligned readonly gv0+8
;;     gv2 = load.i64 notrap aligned gv1+16
;;     gv3 = vmctx
;;     gv4 = load.i64 notrap aligned readonly can_move gv3+8
;;     gv5 = load.i64 notrap aligned readonly can_move gv4+24
;;     gv6 = load.i64 notrap aligned gv4+32
;;     stack_limit = gv2
;;
;;                                 block0(v0: i64, v1: i64, v2: i32):
;; @003c                               trapz v2, user16
;; @003c                               v11 = load.i64 notrap aligned readonly can_move v0+8
;; @003c                               v5 = load.i64 notrap aligned readonly can_move v11+24
;; @003c                               v4 = uextend.i64 v2
;; @003c                               v6 = iadd v5, v4
;; @003c                               v7 = iconst.i64 28
;; @003c                               v8 = iadd v6, v7  ; v7 = 28
;; @003c                               v9 = load.i8 notrap aligned little v8
;; @0040                               jump block1
;;
;;                                 block1:
;; @003c                               v10 = sextend.i32 v9
;; @0040                               return v10
;; }
;;
;; function u0:2(i64 vmctx, i64, i32) -> i32 tail {
;;     gv0 = vmctx
;;     gv1 = load.i64 notrap aligned readonly gv0+8
;;     gv2 = load.i64 notrap aligned gv1+16
;;     gv3 = vmctx
;;     gv4 = load.i64 notrap aligned readonly can_move gv3+8
;;     gv5 = load.i64 notrap aligned readonly can_move gv4+24
;;     gv6 = load.i64 notrap aligned gv4+32
;;     stack_limit = gv2
;;
;;                                 block0(v0: i64, v1: i64, v2: i32):
;; @0045                               trapz v2, user16
;; @0045                               v11 = load.i64 notrap aligned readonly can_move v0+8
;; @0045                               v5 = load.i64 notrap aligned readonly can_move v11+24
;; @0045                               v4 = uextend.i64 v2
;; @0045                               v6 = iadd v5, v4
;; @0045                               v7 = iconst.i64 28
;; @0045                               v8 = iadd v6, v7  ; v7 = 28
;; @0045                               v9 = load.i8 notrap aligned little v8
;; @0049                               jump block1
;;
;;                                 block1:
;; @0045                               v10 = uextend.i32 v9
;; @0049                               return v10
;; }
;;
;; function u0:3(i64 vmctx, i64, i32) -> i32 tail {
;;     gv0 = vmctx
;;     gv1 = load.i64 notrap aligned readonly gv0+8
;;     gv2 = load.i64 notrap aligned gv1+16
;;     gv3 = vmctx
;;     gv4 = load.i64 notrap aligned readonly can_move gv3+8
;;     gv5 = load.i64 notrap aligned readonly can_move gv4+24
;;     gv6 = load.i64 notrap aligned gv4+32
;;     stack_limit = gv2
;;
;;                                 block0(v0: i64, v1: i64, v2: i32):
;; @004e                               trapz v2, user16
;; @004e                               v58 = load.i64 notrap aligned readonly can_move v0+8
;; @004e                               v5 = load.i64 notrap aligned readonly can_move v58+24
;; @004e                               v4 = uextend.i64 v2
;; @004e                               v6 = iadd v5, v4
;; @004e                               v7 = iconst.i64 32
;; @004e                               v8 = iadd v6, v7  ; v7 = 32
;; @004e                               v9 = load.i32 notrap aligned little v8
;;                                     v57 = iconst.i32 1
;; @004e                               v10 = band v9, v57  ; v57 = 1
;;                                     v56 = iconst.i32 0
;; @004e                               v11 = icmp eq v9, v56  ; v56 = 0
;; @004e                               v12 = uextend.i32 v11
;; @004e                               v13 = bor v10, v12
;; @004e                               brif v13, block4, block2
;;
;;                                 block2:
;; @004e                               v14 = uextend.i64 v9
;; @004e                               v16 = iadd.i64 v5, v14
;; @004e                               v17 = load.i32 notrap aligned v16
;; @004e                               v18 = iconst.i32 2
;; @004e                               v19 = band v17, v18  ; v18 = 2
;; @004e                               brif v19, block4, block3
;;
;;                                 block3:
;; @004e                               v21 = load.i64 notrap aligned readonly v0+32
;; @004e                               v22 = load.i32 notrap aligned v21
;; @004e                               v26 = iconst.i64 16
;; @004e                               v27 = iadd.i64 v16, v26  ; v26 = 16
;; @004e                               store notrap aligned v22, v27
;;                                     v60 = iconst.i32 2
;;                                     v61 = bor.i32 v17, v60  ; v60 = 2
;; @004e                               store notrap aligned v61, v16
;; @004e                               v36 = iconst.i64 8
;; @004e                               v37 = iadd.i64 v16, v36  ; v36 = 8
;; @004e                               v38 = load.i64 notrap aligned v37
;;                                     v47 = iconst.i64 1
;; @004e                               v39 = iadd v38, v47  ; v47 = 1
;; @004e                               store notrap aligned v39, v37
;; @004e                               store.i32 notrap aligned v9, v21
;; @004e                               jump block4
;;
;;                                 block4:
;; @0052                               jump block1
;;
;;                                 block1:
;; @0052                               return v9
;; }
