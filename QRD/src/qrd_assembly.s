
.text
.syntax unified

.global qrd_opt_assembly
.arm

qrd_opt_assembly:
  push    {r4,r5,r6,r7,r8,r9,r10,r11,lr}
  add     r6, r0, #1003520
  vpush   {d8-d15}
  mov     r8, r1
  sub     sp, sp, #20
  add     r7, r2, #72
  add     r6, r6, #460
  add     r5, r0, #460
label6:
  mov     r10, r7
  mov     r9, r8
  mov     r4, r5
  mov     r11, #0
label4:
  vldr    s11, [r4, #-8]
  vldr    s12, [r4, #-12]
  vldr    s9, [r4, #-72]
  vldr    s10, [r4, #-76]
  vmul.f32 s13, s11, s11
  vldr    s7, [r4, #-136]
  vmul.f32 s14, s9, s9
  vldr    s6, [pc, #+928]
  vmla.f32 s13, s12, s12
  vldr    s8, [r4, #-140]
  vmul.f32 s15, s7, s7
  vmla.f32 s14, s10, s10
  vldr    s5, [r4, #-200]
  vmla.f32 s15, s8, s8
  vadd.f32 s13, s13, s6
  vmul.f32 s17, s5, s5
  vldr    s6, [r4, #-204]
  vldr    s3, [r4, #-264]
  vadd.f32 s14, s14, s13
  vldr    s4, [r4, #-268]
  vmla.f32 s17, s6, s6
  vmul.f32 s13, s3, s3
  vldr    s1, [r4, #-328]
  vadd.f32 s15, s15, s14
  vmla.f32 s13, s4, s4
  vmul.f32 s14, s1, s1
  vldr    s2, [r4, #-332]
  vldr    s16, [r4, #-392]
  vadd.f32 s17, s17, s15
  vmla.f32 s14, s2, s2
  vmul.f32 s15, s16, s16
  vldr    s0, [r4, #-396]
  vldr    s19, [r4, #-456]
  vadd.f32 s13, s13, s17
  vmla.f32 s15, s0, s0
  vmul.f32 s18, s19, s19
  vldr    s17, [r4, #-460]
  vadd.f32 s14, s14, s13
  pld     [r4]
  vmla.f32 s18, s17, s17
  pld     [r4, #-64]
  vadd.f32 s15, s15, s14
  pld     [r4, #-128]
  vadd.f32 s18, s18, s15
  vcmp.f32 s18, #0.0
  vmrs    APSR_nzcv, fpscr
  vsqrt.f32 s20, s18
  bmi     label1
  pld     [r10]
  vstr    s20, [r10, #-72]
label5:
  vmov.f32 s15, #1.0
  add     r11, r11, #1
  cmp     r11, #8
  vdiv.f32 s13, s15, s20
  vmul.f32 s15, s13, s19
  vmul.f32 s12, s13, s12
  vmul.f32 s11, s13, s11
  vmul.f32 s10, s13, s10
  vmul.f32 s9, s13, s9
  vmul.f32 s8, s13, s8
  vmul.f32 s7, s13, s7
  vmul.f32 s6, s13, s6
  vmul.f32 s5, s13, s5
  vmul.f32 s4, s13, s4
  vmul.f32 s3, s13, s3
  vmul.f32 s2, s13, s2
  vmul.f32 s1, s13, s1
  vmul.f32 s0, s13, s0
  vmul.f32 s16, s13, s16
  vmul.f32 s17, s13, s17
  vstr    s15, [sp, #+4]
  vstr    s12, [r9, #+448]
  vstr    s11, [r9, #+452]
  vstr    s10, [r9, #+384]
  vstr    s9, [r9, #+388]
  vstr    s8, [r9, #+320]
  vstr    s7, [r9, #+324]
  vstr    s6, [r9, #+256]
  vstr    s5, [r9, #+260]
  vstr    s4, [r9, #+192]
  vstr    s3, [r9, #+196]
  vstr    s2, [r9, #+128]
  vstr    s1, [r9, #+132]
  vstr    s0, [r9, #+64]
  vstr    s16, [r9, #+68]
  vstr    s17, [r9]
  vstr    s15, [r9, #+4]
  beq     label2
  add     r3, r4, #16
  sub     r2, r10, #44
  mov     r1, r11
label3:
  vldr    s13, [r3, #-20]
  add     r1, r1, #1
  vldr    s14, [r2, #-20]
  cmp     r1, #8
  vldr    s15, [r2, #-16]
  vldr    s19, [r3, #-84]
  vldr    s18, [r3, #-80]
  vmla.f32 s14, s13, s12
  vldr    s13, [r3, #-16]
  vldr    s21, [r3, #-148]
  vldr    s20, [r3, #-144]
  vmla.f32 s15, s13, s12
  vldr    s23, [r3, #-212]
  vldr    s22, [r3, #-208]
  vmla.f32 s14, s13, s11
  vldr    s13, [r3, #-20]
  vldr    s25, [r3, #-276]
  vldr    s24, [r3, #-272]
  vmls.f32 s15, s13, s11
  vldr    s27, [r3, #-340]
  vmla.f32 s14, s19, s10
  vldr    s26, [r3, #-336]
  vldr    s29, [r3, #-404]
  vldr    s28, [r3, #-400]
  vmla.f32 s15, s18, s10
  vldr    s31, [r3, #-468]
  vmla.f32 s14, s18, s9
  vldr    s30, [r3, #-464]
  vldr    s13, [sp, #+4]
  pld     [r2]
  add     r2, r2, #8
  vmls.f32 s15, s19, s9
  pld     [r3]
  add     r3, r3, #8
  vmla.f32 s14, s21, s8
  vmla.f32 s15, s20, s8
  vmla.f32 s14, s20, s7
  vmls.f32 s15, s21, s7
  vmla.f32 s14, s23, s6
  vmla.f32 s15, s22, s6
  vmla.f32 s14, s22, s5
  vmls.f32 s15, s23, s5
  vmla.f32 s14, s25, s4
  vmla.f32 s15, s24, s4
  vmla.f32 s14, s24, s3
  vmls.f32 s15, s25, s3
  vmla.f32 s14, s27, s2
  vmla.f32 s15, s26, s2
  vmla.f32 s14, s26, s1
  vmls.f32 s15, s27, s1
  vmla.f32 s14, s29, s0
  vmla.f32 s15, s28, s0
  vmla.f32 s14, s28, s16
  vmls.f32 s15, s29, s16
  vmla.f32 s14, s31, s17
  vmla.f32 s15, s30, s17
  vmla.f32 s14, s30, s13
  vmls.f32 s15, s31, s13
  vmls.f32 s18, s14, s9
  vmls.f32 s30, s14, s13
  vldr    s13, [r3, #-28]
  vmls.f32 s31, s14, s17
  vmls.f32 s13, s14, s12
  vstr    s18, [sp, #+8]
  vldr    s18, [r3, #-24]
  vmls.f32 s29, s14, s0
  vmls.f32 s18, s14, s11
  vmls.f32 s28, s14, s16
  vmla.f32 s13, s15, s11
  vmls.f32 s27, s14, s2
  vstr    s18, [sp, #+12]
  vldr    s18, [sp, #+4]
  vmls.f32 s26, s14, s1
  vmls.f32 s25, s14, s4
  vmls.f32 s24, s14, s3
  vmls.f32 s23, s14, s6
  vmls.f32 s22, s14, s5
  vmls.f32 s21, s14, s8
  vmls.f32 s20, s14, s7
  vmls.f32 s19, s14, s10
  vstr    s13, [r3, #-28]
  vmla.f32 s31, s15, s18
  vldr    s13, [sp, #+12]
  vldr    s18, [sp, #+8]
  vmls.f32 s30, s15, s17
  vmla.f32 s29, s15, s16
  vmls.f32 s28, s15, s0
  vmla.f32 s27, s15, s1
  vmls.f32 s26, s15, s2
  vmla.f32 s25, s15, s3
  vmls.f32 s24, s15, s4
  vmla.f32 s23, s15, s5
  vmls.f32 s22, s15, s6
  vmla.f32 s21, s15, s7
  vmls.f32 s20, s15, s8
  vmla.f32 s19, s15, s9
  vmls.f32 s18, s15, s10
  vmls.f32 s13, s15, s12
  vstr    s14, [r2, #-28]
  vstr    s13, [r3, #-24]
  vstr    s31, [r3, #-476]
  vstr    s30, [r3, #-472]
  vstr    s29, [r3, #-412]
  vstr    s28, [r3, #-408]
  vstr    s27, [r3, #-348]
  vstr    s26, [r3, #-344]
  vstr    s25, [r3, #-284]
  vstr    s24, [r3, #-280]
  vstr    s23, [r3, #-220]
  vstr    s22, [r3, #-216]
  vstr    s15, [r2, #-24]
  vstr    s21, [r3, #-156]
  vstr    s20, [r3, #-152]
  vstr    s19, [r3, #-92]
  vstr    s18, [r3, #-88]
  bne     label3
  add     r4, r4, #8
  add     r9, r9, #8
  add     r10, r10, #72
  b       label4
label1:
  vmov.f32 s0, s18
  bl      sqrtf
  vmov.f32 s0, s18
  vstr    s20, [r10, #-72]
  bl      sqrtf
  vldr    s12, [r4, #-12]
  vldr    s11, [r4, #-8]
  vldr    s10, [r4, #-76]
  vldr    s9, [r4, #-72]
  vldr    s8, [r4, #-140]
  vldr    s7, [r4, #-136]
  vldr    s6, [r4, #-204]
  vldr    s5, [r4, #-200]
  vldr    s4, [r4, #-268]
  vldr    s3, [r4, #-264]
  vldr    s2, [r4, #-332]
  vldr    s1, [r4, #-328]
  vldr    s0, [r4, #-396]
  vldr    s16, [r4, #-392]
  vldr    s17, [r4, #-460]
  vldr    s19, [r4, #-456]
  b       label5
label2:
  add     r5, r5, #512
  add     r8, r8, #512
  cmp     r6, r5
  add     r7, r7, #512
  bne     label6
  add     sp, sp, #20
  vpop    {d8-d15}
  pop     {r4,r5,r6,r7,r8,r9,r10,r11,pc}
  .byte 0x00
  .byte 0x00
  .byte 0x00
  .byte 0x00


