[@@@ocaml.warning "-30"]

type test_type =
  | Encode of int
  | Decode

type test_id =
  | Int32_list 
  | Int_list 
  | Int_repeated 
  | Int_packed_repeated 

type test_request = {
  type_ : test_type;
  file_name : string;
  test_id : test_id;
}

and test_request_mutable = {
  mutable type_ : test_type;
  mutable file_name : string;
  mutable test_id : test_id;
}

type test_requests = {
  requests : test_requests list;
}

and test_requests_mutable = {
  mutable requests : test_requests list;
}

type encode_data = {
  creation_time : float;
  encode_time : float;
  to_file_time : float;
}

and encode_data_mutable = {
  mutable creation_time : float;
  mutable encode_time : float;
  mutable to_file_time : float;
}

type decode_data = {
  from_file_time : float;
  decode_time : float;
}

and decode_data_mutable = {
  mutable from_file_time : float;
  mutable decode_time : float;
}

type test_response_data =
  | Encode of encode_data
  | Decode of decode_data

and test_response = {
  difficulty_size : int;
  test_id : test_id;
  data : test_response_data;
}

and test_response_mutable = {
  mutable difficulty_size : int;
  mutable test_id : test_id;
  mutable data : test_response_data;
}

type test_responses = {
  responses : test_responses list;
}

and test_responses_mutable = {
  mutable responses : test_responses list;
}

type int32_list = {
  int32_list : int32 list;
}

and int32_list_mutable = {
  mutable int32_list : int32 list;
}

type int_list = {
  int_list : int list;
}

and int_list_mutable = {
  mutable int_list : int list;
}

type int_repeated = {
  int_repeated : int Pbrt.Repeated_field.t;
}

and int_repeated_mutable = {
  int_repeated : int Pbrt.Repeated_field.t;
}

type int_packed_repeated = {
  int_packed_repeated : int Pbrt.Repeated_field.t;
}

and int_packed_repeated_mutable = {
  int_packed_repeated : int Pbrt.Repeated_field.t;
}

let rec default_test_type () : test_type = Encode (0)

let rec default_test_id () = (Int32_list:test_id)

let rec default_test_request () : test_request = {
  type_ = default_test_type ();
  file_name = "";
  test_id = default_test_id ();
}

and default_test_request_mutable () : test_request_mutable = {
  type_ = default_test_type ();
  file_name = "";
  test_id = default_test_id ();
}

let rec default_test_requests () : test_requests = {
  requests = [];
}

and default_test_requests_mutable () : test_requests_mutable = {
  requests = [];
}

let rec default_encode_data () : encode_data = {
  creation_time = 0.;
  encode_time = 0.;
  to_file_time = 0.;
}

and default_encode_data_mutable () : encode_data_mutable = {
  creation_time = 0.;
  encode_time = 0.;
  to_file_time = 0.;
}

let rec default_decode_data () : decode_data = {
  from_file_time = 0.;
  decode_time = 0.;
}

and default_decode_data_mutable () : decode_data_mutable = {
  from_file_time = 0.;
  decode_time = 0.;
}


let rec default_test_response () : test_response = {
  difficulty_size = 0;
  test_id = default_test_id ();
  data = Encode (default_encode_data ());
}

and default_test_response_mutable () : test_response_mutable = {
  difficulty_size = 0;
  test_id = default_test_id ();
  data = Encode (default_encode_data ());
}

let rec default_test_responses () : test_responses = {
  responses = [];
}

and default_test_responses_mutable () : test_responses_mutable = {
  responses = [];
}

let rec default_int32_list () : int32_list = {
  int32_list = [];
}

and default_int32_list_mutable () : int32_list_mutable = {
  int32_list = [];
}

let rec default_int_list () : int_list = {
  int_list = [];
}

and default_int_list_mutable () : int_list_mutable = {
  int_list = [];
}

let rec default_int_repeated () : int_repeated = {
  int_repeated = Pbrt.Repeated_field.make (0);
}

and default_int_repeated_mutable () : int_repeated_mutable = {
  int_repeated = Pbrt.Repeated_field.make (0);
}

let rec default_int_packed_repeated () : int_packed_repeated = {
  int_packed_repeated = Pbrt.Repeated_field.make (0);
}

and default_int_packed_repeated_mutable () : int_packed_repeated_mutable = {
  int_packed_repeated = Pbrt.Repeated_field.make (0);
}

let rec decode_test_type d = 
  let rec loop () = 
    let ret:test_type = match Pbrt.Decoder.key d with
      | None -> failwith "None of the known key is found"
      | Some (1, _) -> Encode (Pbrt.Decoder.int_as_varint d)
      | Some (2, _) -> (Pbrt.Decoder.empty_nested d ; Decode)
      | Some (n, payload_kind) -> (
        Pbrt.Decoder.skip d payload_kind; 
        loop () 
      )
    in
    ret
  in
  loop ()

let rec decode_test_id d = 
  match Pbrt.Decoder.int_as_varint d with
  | 1 -> (Int32_list:test_id)
  | 2 -> (Int_list:test_id)
  | 3 -> (Int_repeated:test_id)
  | 4 -> (Int_packed_repeated:test_id)
  | _ -> failwith "Unknown value for enum test_id"

let rec decode_test_request d =
  let v = default_test_request_mutable () in
  let rec loop () = 
    match Pbrt.Decoder.key d with
    | None -> (
    )
    | Some (1, Pbrt.Bytes) -> v.type_ <- (decode_test_type (Pbrt.Decoder.nested d)); loop ()
    | Some (2, Pbrt.Bytes) -> v.file_name <- (Pbrt.Decoder.string d); loop ()
    | Some (3, Pbrt.Varint) -> v.test_id <- (decode_test_id d); loop ()
    | Some (n, payload_kind) -> Pbrt.Decoder.skip d payload_kind; loop ()
  in
  loop ();
  let v:test_request = Obj.magic v in
  v

let rec decode_test_requests d =
  let v = default_test_requests_mutable () in
  let rec loop () = 
    match Pbrt.Decoder.key d with
    | None -> (
      v.requests <- List.rev v.requests;
    )
    | Some (1, Pbrt.Bytes) -> v.requests <- (decode_test_requests (Pbrt.Decoder.nested d)) :: v.requests; loop ()
    | Some (n, payload_kind) -> Pbrt.Decoder.skip d payload_kind; loop ()
  in
  loop ();
  let v:test_requests = Obj.magic v in
  v

let rec decode_encode_data d =
  let v = default_encode_data_mutable () in
  let rec loop () = 
    match Pbrt.Decoder.key d with
    | None -> (
    )
    | Some (1, Pbrt.Bits64) -> v.creation_time <- (Pbrt.Decoder.float_as_bits64 d); loop ()
    | Some (2, Pbrt.Bits64) -> v.encode_time <- (Pbrt.Decoder.float_as_bits64 d); loop ()
    | Some (3, Pbrt.Bits64) -> v.to_file_time <- (Pbrt.Decoder.float_as_bits64 d); loop ()
    | Some (n, payload_kind) -> Pbrt.Decoder.skip d payload_kind; loop ()
  in
  loop ();
  let v:encode_data = Obj.magic v in
  v

let rec decode_decode_data d =
  let v = default_decode_data_mutable () in
  let rec loop () = 
    match Pbrt.Decoder.key d with
    | None -> (
    )
    | Some (1, Pbrt.Bits64) -> v.from_file_time <- (Pbrt.Decoder.float_as_bits64 d); loop ()
    | Some (2, Pbrt.Bits64) -> v.decode_time <- (Pbrt.Decoder.float_as_bits64 d); loop ()
    | Some (n, payload_kind) -> Pbrt.Decoder.skip d payload_kind; loop ()
  in
  loop ();
  let v:decode_data = Obj.magic v in
  v


let rec decode_test_response d =
  let v = default_test_response_mutable () in
  let rec loop () = 
    match Pbrt.Decoder.key d with
    | None -> (
    )
    | Some (1, Pbrt.Varint) -> v.difficulty_size <- (Pbrt.Decoder.int_as_varint d); loop ()
    | Some (3, Pbrt.Varint) -> v.test_id <- (decode_test_id d); loop ()
    | Some (4, Pbrt.Bytes) -> v.data <- Encode (decode_encode_data (Pbrt.Decoder.nested d)) ; loop ()
    | Some (5, Pbrt.Bytes) -> v.data <- Decode (decode_decode_data (Pbrt.Decoder.nested d)) ; loop ()
    | Some (n, payload_kind) -> Pbrt.Decoder.skip d payload_kind; loop ()
  in
  loop ();
  let v:test_response = Obj.magic v in
  v

let rec decode_test_responses d =
  let v = default_test_responses_mutable () in
  let rec loop () = 
    match Pbrt.Decoder.key d with
    | None -> (
      v.responses <- List.rev v.responses;
    )
    | Some (1, Pbrt.Bytes) -> v.responses <- (decode_test_responses (Pbrt.Decoder.nested d)) :: v.responses; loop ()
    | Some (n, payload_kind) -> Pbrt.Decoder.skip d payload_kind; loop ()
  in
  loop ();
  let v:test_responses = Obj.magic v in
  v

let rec decode_int32_list d =
  let v = default_int32_list_mutable () in
  let rec loop () = 
    match Pbrt.Decoder.key d with
    | None -> (
      v.int32_list <- List.rev v.int32_list;
    )
    | Some (1, Pbrt.Varint) -> v.int32_list <- (Pbrt.Decoder.int32_as_varint d) :: v.int32_list; loop ()
    | Some (n, payload_kind) -> Pbrt.Decoder.skip d payload_kind; loop ()
  in
  loop ();
  let v:int32_list = Obj.magic v in
  v

let rec decode_int_list d =
  let v = default_int_list_mutable () in
  let rec loop () = 
    match Pbrt.Decoder.key d with
    | None -> (
      v.int_list <- List.rev v.int_list;
    )
    | Some (1, Pbrt.Varint) -> v.int_list <- (Pbrt.Decoder.int_as_varint d) :: v.int_list; loop ()
    | Some (n, payload_kind) -> Pbrt.Decoder.skip d payload_kind; loop ()
  in
  loop ();
  let v:int_list = Obj.magic v in
  v

let rec decode_int_repeated d =
  let v = default_int_repeated_mutable () in
  let rec loop () = 
    match Pbrt.Decoder.key d with
    | None -> (
    )
    | Some (1, Pbrt.Varint) -> Pbrt.Repeated_field.add (Pbrt.Decoder.int_as_varint d) v.int_repeated ; loop ()
    | Some (n, payload_kind) -> Pbrt.Decoder.skip d payload_kind; loop ()
  in
  loop ();
  let v:int_repeated = Obj.magic v in
  v

let rec decode_int_packed_repeated d =
  let v = default_int_packed_repeated_mutable () in
  let rec loop () = 
    match Pbrt.Decoder.key d with
    | None -> (
    )
    | Some (1, Pbrt.Bytes) -> (Pbrt.Decoder.packed_fold (fun () d -> Pbrt.Repeated_field.add (Pbrt.Decoder.int_as_varint d) v.int_packed_repeated) () d); loop ()
    | Some (n, payload_kind) -> Pbrt.Decoder.skip d payload_kind; loop ()
  in
  loop ();
  let v:int_packed_repeated = Obj.magic v in
  v

let rec encode_test_type (v:test_type) encoder = 
  match v with
  | Encode x -> (
    Pbrt.Encoder.key (1, Pbrt.Varint) encoder; 
    Pbrt.Encoder.int_as_varint x encoder;
  )
  | Decode -> (
    Pbrt.Encoder.key (2, Pbrt.Bytes) encoder; 
    Pbrt.Encoder.empty_nested encoder;
  )

let rec encode_test_id (v:test_id) encoder =
  match v with
  | Int32_list -> Pbrt.Encoder.int_as_varint 1 encoder
  | Int_list -> Pbrt.Encoder.int_as_varint 2 encoder
  | Int_repeated -> Pbrt.Encoder.int_as_varint 3 encoder
  | Int_packed_repeated -> Pbrt.Encoder.int_as_varint 4 encoder

let rec encode_test_request (v:test_request) encoder = 
  Pbrt.Encoder.key (1, Pbrt.Bytes) encoder; 
  Pbrt.Encoder.nested (encode_test_type v.type_) encoder;
  Pbrt.Encoder.key (2, Pbrt.Bytes) encoder; 
  Pbrt.Encoder.string v.file_name encoder;
  Pbrt.Encoder.key (3, Pbrt.Varint) encoder; 
  encode_test_id v.test_id encoder;
  ()

let rec encode_test_requests (v:test_requests) encoder = 
  List.iter (fun x -> 
    Pbrt.Encoder.key (1, Pbrt.Bytes) encoder; 
    Pbrt.Encoder.nested (encode_test_requests x) encoder;
  ) v.requests;
  ()

let rec encode_encode_data (v:encode_data) encoder = 
  Pbrt.Encoder.key (1, Pbrt.Bits64) encoder; 
  Pbrt.Encoder.float_as_bits64 v.creation_time encoder;
  Pbrt.Encoder.key (2, Pbrt.Bits64) encoder; 
  Pbrt.Encoder.float_as_bits64 v.encode_time encoder;
  Pbrt.Encoder.key (3, Pbrt.Bits64) encoder; 
  Pbrt.Encoder.float_as_bits64 v.to_file_time encoder;
  ()

let rec encode_decode_data (v:decode_data) encoder = 
  Pbrt.Encoder.key (1, Pbrt.Bits64) encoder; 
  Pbrt.Encoder.float_as_bits64 v.from_file_time encoder;
  Pbrt.Encoder.key (2, Pbrt.Bits64) encoder; 
  Pbrt.Encoder.float_as_bits64 v.decode_time encoder;
  ()


let rec encode_test_response (v:test_response) encoder = 
  Pbrt.Encoder.key (1, Pbrt.Varint) encoder; 
  Pbrt.Encoder.int_as_varint v.difficulty_size encoder;
  Pbrt.Encoder.key (3, Pbrt.Varint) encoder; 
  encode_test_id v.test_id encoder;
  (match v.data with
  | Encode x -> (
    Pbrt.Encoder.key (4, Pbrt.Bytes) encoder; 
    Pbrt.Encoder.nested (encode_encode_data x) encoder;
  )
  | Decode x -> (
    Pbrt.Encoder.key (5, Pbrt.Bytes) encoder; 
    Pbrt.Encoder.nested (encode_decode_data x) encoder;
  )
  );
  ()

let rec encode_test_responses (v:test_responses) encoder = 
  List.iter (fun x -> 
    Pbrt.Encoder.key (1, Pbrt.Bytes) encoder; 
    Pbrt.Encoder.nested (encode_test_responses x) encoder;
  ) v.responses;
  ()

let rec encode_int32_list (v:int32_list) encoder = 
  List.iter (fun x -> 
    Pbrt.Encoder.key (1, Pbrt.Varint) encoder; 
    Pbrt.Encoder.int32_as_varint x encoder;
  ) v.int32_list;
  ()

let rec encode_int_list (v:int_list) encoder = 
  List.iter (fun x -> 
    Pbrt.Encoder.key (1, Pbrt.Varint) encoder; 
    Pbrt.Encoder.int_as_varint x encoder;
  ) v.int_list;
  ()

let rec encode_int_repeated (v:int_repeated) encoder = 
  Pbrt.Repeated_field.iter (fun x -> 
    Pbrt.Encoder.key (1, Pbrt.Varint) encoder; 
    Pbrt.Encoder.int_as_varint x encoder;
  ) v.int_repeated;
  ()

let rec encode_int_packed_repeated (v:int_packed_repeated) encoder = 
  Pbrt.Encoder.key (1, Pbrt.Bytes) encoder; 
  Pbrt.Encoder.nested (fun encoder ->
    Pbrt.Repeated_field.iter (fun x -> 
      Pbrt.Encoder.int_as_varint x encoder;
    ) v.int_packed_repeated;
  ) encoder;
  ()

let rec pp_test_type fmt (v:test_type) =
  match v with
  | Encode x -> Format.fprintf fmt "@[Encode(%a)@]" Pbrt.Pp.pp_int x
  | Decode  -> Format.fprintf fmt "Decode"

let rec pp_test_id fmt (v:test_id) =
  match v with
  | Int32_list -> Format.fprintf fmt "Int32_list"
  | Int_list -> Format.fprintf fmt "Int_list"
  | Int_repeated -> Format.fprintf fmt "Int_repeated"
  | Int_packed_repeated -> Format.fprintf fmt "Int_packed_repeated"

let rec pp_test_request fmt (v:test_request) = 
  let pp_i fmt () =
    Format.pp_open_vbox fmt 1;
    Pbrt.Pp.pp_record_field "type_" pp_test_type fmt v.type_;
    Pbrt.Pp.pp_record_field "file_name" Pbrt.Pp.pp_string fmt v.file_name;
    Pbrt.Pp.pp_record_field "test_id" pp_test_id fmt v.test_id;
    Format.pp_close_box fmt ()
  in
  Pbrt.Pp.pp_brk pp_i fmt ()

let rec pp_test_requests fmt (v:test_requests) = 
  let pp_i fmt () =
    Format.pp_open_vbox fmt 1;
    Pbrt.Pp.pp_record_field "requests" (Pbrt.Pp.pp_list pp_test_requests) fmt v.requests;
    Format.pp_close_box fmt ()
  in
  Pbrt.Pp.pp_brk pp_i fmt ()

let rec pp_encode_data fmt (v:encode_data) = 
  let pp_i fmt () =
    Format.pp_open_vbox fmt 1;
    Pbrt.Pp.pp_record_field "creation_time" Pbrt.Pp.pp_float fmt v.creation_time;
    Pbrt.Pp.pp_record_field "encode_time" Pbrt.Pp.pp_float fmt v.encode_time;
    Pbrt.Pp.pp_record_field "to_file_time" Pbrt.Pp.pp_float fmt v.to_file_time;
    Format.pp_close_box fmt ()
  in
  Pbrt.Pp.pp_brk pp_i fmt ()

let rec pp_decode_data fmt (v:decode_data) = 
  let pp_i fmt () =
    Format.pp_open_vbox fmt 1;
    Pbrt.Pp.pp_record_field "from_file_time" Pbrt.Pp.pp_float fmt v.from_file_time;
    Pbrt.Pp.pp_record_field "decode_time" Pbrt.Pp.pp_float fmt v.decode_time;
    Format.pp_close_box fmt ()
  in
  Pbrt.Pp.pp_brk pp_i fmt ()

let rec pp_test_response_data fmt (v:test_response_data) =
  match v with
  | Encode x -> Format.fprintf fmt "@[Encode(%a)@]" pp_encode_data x
  | Decode x -> Format.fprintf fmt "@[Decode(%a)@]" pp_decode_data x

and pp_test_response fmt (v:test_response) = 
  let pp_i fmt () =
    Format.pp_open_vbox fmt 1;
    Pbrt.Pp.pp_record_field "difficulty_size" Pbrt.Pp.pp_int fmt v.difficulty_size;
    Pbrt.Pp.pp_record_field "test_id" pp_test_id fmt v.test_id;
    Pbrt.Pp.pp_record_field "data" pp_test_response_data fmt v.data;
    Format.pp_close_box fmt ()
  in
  Pbrt.Pp.pp_brk pp_i fmt ()

let rec pp_test_responses fmt (v:test_responses) = 
  let pp_i fmt () =
    Format.pp_open_vbox fmt 1;
    Pbrt.Pp.pp_record_field "responses" (Pbrt.Pp.pp_list pp_test_responses) fmt v.responses;
    Format.pp_close_box fmt ()
  in
  Pbrt.Pp.pp_brk pp_i fmt ()

let rec pp_int32_list fmt (v:int32_list) = 
  let pp_i fmt () =
    Format.pp_open_vbox fmt 1;
    Pbrt.Pp.pp_record_field "int32_list" (Pbrt.Pp.pp_list Pbrt.Pp.pp_int32) fmt v.int32_list;
    Format.pp_close_box fmt ()
  in
  Pbrt.Pp.pp_brk pp_i fmt ()

let rec pp_int_list fmt (v:int_list) = 
  let pp_i fmt () =
    Format.pp_open_vbox fmt 1;
    Pbrt.Pp.pp_record_field "int_list" (Pbrt.Pp.pp_list Pbrt.Pp.pp_int) fmt v.int_list;
    Format.pp_close_box fmt ()
  in
  Pbrt.Pp.pp_brk pp_i fmt ()

let rec pp_int_repeated fmt (v:int_repeated) = 
  let pp_i fmt () =
    Format.pp_open_vbox fmt 1;
    Pbrt.Pp.pp_record_field "int_repeated" (Pbrt.Pp.pp_list Pbrt.Pp.pp_int) fmt (Pbrt.Repeated_field.to_list v.int_repeated);
    Format.pp_close_box fmt ()
  in
  Pbrt.Pp.pp_brk pp_i fmt ()

let rec pp_int_packed_repeated fmt (v:int_packed_repeated) = 
  let pp_i fmt () =
    Format.pp_open_vbox fmt 1;
    Pbrt.Pp.pp_record_field "int_packed_repeated" (Pbrt.Pp.pp_list Pbrt.Pp.pp_int) fmt (Pbrt.Repeated_field.to_list v.int_packed_repeated);
    Format.pp_close_box fmt ()
  in
  Pbrt.Pp.pp_brk pp_i fmt ()
