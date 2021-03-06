﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Cube.Model.DTO
{
    public class FunctionDTO
    {
        public Guid Id { get; set; }
        public string Code { get; set; }
        public string Language_Key { get; set; }
        public string Url { get; set; }
        public string System_Id { get; set; }
        public Guid Parent_Function_Id { get; set; }
        public List<FunctionDTO> SubFunctionList { get; set; }
        public FunctionDTO()
        {
            SubFunctionList = new List<FunctionDTO>();
        }
    }
}