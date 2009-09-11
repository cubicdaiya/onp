--[[
     compose Longest Common Subsequence and Shortest Edit Script.
     The algorithm implemented here is based on "An O(NP) Sequence Comparison Algorithm"                                   
     by described by Sun Wu, Udi Manber and Gene Myers 
--]]
ONP = {}
SES_DELETE = -1
SES_COMMON = 0
SES_ADD    = 1
function ONP.new (a, b)
   local self = {
      A = a,
      B = b,
      M = string.len(a),
      N = string.len(b),
      path       = {},
      pathposi   = {},
      P          = {},
      ses        = {},
      seselem    = {},
      lcs        = "",
      editdis    = 0,
      reverse    = false,
   }
   -- getter
   function self.geteditdistance () 
      return self.editdis
   end
   function self.getlcs ()
      return self.lcs
   end
   function self.getses ()
      return self.ses
   end
   -- constructor
   function self.P.new (x_, y_, k_)
      local self = { x=x_, y=y_, k=k_ }
      return self
   end
   function self.seselem.new (elem_, type_)
      local self = { elem=elem_, type=type_}
      return self
   end
   function self.compose ()
      offset = self.M + 1
      delta  = self.N - self.M
      size   = self.M + self.N + 3
      fp = {}
      for i = 0, size-1 do
         fp[i]   = -1
         self.path[i] = -1
      end
      p = -1
      repeat
         p = p + 1
         for k=-p, delta-1, 1 do
            fp[k+offset] = self.snake(k, fp[k-1+offset]+1, fp[k+1+offset])
         end
         for k=delta+p,delta+1, -1 do
            fp[k+offset] = self.snake(k, fp[k-1+offset]+1, fp[k+1+offset])
         end
         fp[delta+offset] = self.snake(delta, fp[delta-1+offset]+1, fp[delta+1+offset])
      until fp[delta+offset] >= self.N
      self.editdis = delta + 2 * p
      r    = self.path[delta+offset]
      epc  = {}
      while r ~= -1 do
         epc[#epc+1] = self.P.new(self.pathposi[r+1].x, self.pathposi[r+1].y, nil)
         r = self.pathposi[r+1].k
      end
      self.recordseq(epc)
   end
   function self.recordseq (epc)
      x_idx,  y_idx  = 1, 1
      px_idx, py_idx = 0, 0
      for i=#epc, 1, -1 do
         while (px_idx < epc[i].x or py_idx < epc[i].y) do
            if (epc[i].y - epc[i].x) > (py_idx - px_idx) then
               elem = string.sub(self.B, y_idx, y_idx)
               if self.reverse then 
                  type = SES_DELETE
               else
                  type = SES_ADD
               end
               self.ses[#self.ses+1] = self.seselem.new(elem, type)
               y_idx  = y_idx  + 1
               py_idx = py_idx + 1
            elseif epc[i].y - epc[i].x < py_idx - px_idx then
               elem = string.sub(self.A, x_idx, x_idx)
               if self.reverse then 
                  type = SES_ADD
               else
                  type = SES_DELETE
               end
               self.ses[#self.ses+1] = self.seselem.new(elem, type)
               x_idx  = x_idx  + 1
               px_idx = px_idx + 1
            else 
               elem = string.sub(self.A, x_idx, x_idx)
               type = SES_COMMON
               self.lcs = self.lcs .. elem
               self.ses[#self.ses+1] = self.seselem.new(elem, type)
               x_idx  = x_idx  + 1
               y_idx  = y_idx  + 1
               px_idx = px_idx + 1
               py_idx = py_idx + 1
            end
         end
      end
   end
   function self.snake (k, p, pp)
      r = 0;
      if p > pp then
         r = self.path[k-1+offset];
      else
         r = self.path[k+1+offset];
      end
      y = math.max(p, pp);
      x = y - k
      while (x < self.M and y < self.N and 
             string.sub(self.A, x+1, x+1) == string.sub(self.B, y+1, y+1)) 
      do
         x = x + 1
         y = y + 1
      end
      self.path[k+offset] = #self.pathposi
      p = self.P.new(x, y, r)
      self.pathposi[#self.pathposi+1] = p
      return y
   end
   if self.M >= self.N then
      self.A, self.B = self.B, self.A
      self.M, self.N = self.N, self.M
      self.reverse = true
   end
   return self
end
